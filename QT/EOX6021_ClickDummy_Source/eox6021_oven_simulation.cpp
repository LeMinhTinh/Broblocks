#include "eox6021_oven_simulation.h"

#include "eox6021_backend.h"
#include <cmath>

namespace BSH
{

OvenSimulation::OvenSimulation(EOX6021BackEnd *backend) :
    m_backend(backend)
{}

void OvenSimulation::start()
{
    QTimer *simulationTimer {new QTimer(this)};
    connect(simulationTimer, SIGNAL(timeout()), this, SLOT(simulationStep()));
    simulationTimer->start(1000);
}

void OvenSimulation::simulationStep()
{
    int oldWallClock {m_backend->getWallClock()};
    int wallClock {oldWallClock + 1};

    EOX6021Program* program {m_backend->getCurrentProgram()};
    // Only run program simulation steps for running programs
    if (program && program->isProgramRunning()) {
        EOX6021ProgramDefinition* programDefinition {program->getDefinition()};
        EOX6021Program::ProgramStatus programStatus {program->getStatus()};
        auto microwaveOption = programDefinition->getMicrowave();
        bool isAirHeatProgram {!programDefinition->getIsMicrowaveProgram()};
        int remainingTime {program->getRemainingTime()};
        int waitingTime {program->getWaitingTime()};

        qreal currentMicrowavePower {m_backend->getMicrowavePower()};
        qreal currentTemperature {m_backend->getCurrentTemperature()};
        qreal targetTemperature {static_cast<qreal>(programDefinition->getTemperature() ? programDefinition->getTemperature()->value() : 0)};
        bool useQuickHeat {programDefinition->getQuickHeat() ? programDefinition->getQuickHeat()->isEnabled() : false};
        qreal heatingDelta {useQuickHeat ? degreePerSecondQuickHeating : degreePerSecondNormalHeating};
        int meal_flip_time {programDefinition->getIsMeal() ? (programDefinition->getDuration()->value() / 2 + program->getStartTime()) : 0};
        auto degredationSteps = m_backend->getMicrowaveBoostSteps();

        // Calculate time until microwave boost is degredated
        int nextMicrowaveDegredationTime = -1;
        if( microwaveOption->value() > m_backend->getMicrowaveBoostThreshold() && m_microwave_boost_degredation_index < degredationSteps.size()) {
            nextMicrowaveDegredationTime = m_backend->getMicrowaveLastChangeTime() + degredationSteps[m_microwave_boost_degredation_index].secondsTillDegradation;
        }

        // Advance time if requested
        if (m_fastForwardRequested) {
            int eventTime {wallClock};
            if (programStatus == EOX6021Program::ProgramStatus::WAITING) {
                eventTime = oldWallClock + waitingTime;
            } else if(program->getDefinition()->getIsCleaningProgram()) {
                if (remainingTime > 0) {
                    eventTime = oldWallClock + remainingTime;
                }
            } else if (programStatus == EOX6021Program::ProgramStatus::PREHEATING) {
                eventTime = oldWallClock + static_cast<int>(std::ceil((targetTemperature - currentTemperature) / heatingDelta));
                if (programDefinition->getIsMeal() && oldWallClock < meal_flip_time) {
                    eventTime = meal_flip_time;
                }
                if (remainingTime > 0) {
                    eventTime = std::min(eventTime, oldWallClock + remainingTime);
                }
                if (microwaveOption->isEnabled() && nextMicrowaveDegredationTime > 0 && m_microwave_boost_degredation_index == 0) {
                    eventTime = std::min(eventTime, nextMicrowaveDegredationTime);
                }
            } else if (programStatus == EOX6021Program::ProgramStatus::HEATING) {
                if (programDefinition->getIsMeal() && oldWallClock < meal_flip_time) {
                    eventTime = meal_flip_time;
                } else if (remainingTime > 0) {
                    eventTime = oldWallClock + remainingTime;
                }
                if (microwaveOption->isEnabled() && nextMicrowaveDegredationTime > 0 && m_microwave_boost_degredation_index == 0) {
                    eventTime = std::min(eventTime, nextMicrowaveDegredationTime);
                }
            }

            // one cycle is automatically done by the rest of the simulation
            int wallClockDelta {eventTime - oldWallClock - 4};
            // only fastforward if not currently already close to fastforward point
            if(wallClockDelta > 0) {
                wallClock += wallClockDelta;
                if(programStatus != EOX6021Program::ProgramStatus::WAITING) {
                    currentTemperature += heatingDelta * wallClockDelta;
                }
            }
            m_fastForwardRequested = false;

            if(wallClock > m_backend->getAlarmResetTime() && m_backend->getAlarmResetTime() > 0) m_backend->setAlarmIndex(0);

        }

        // Advance countdown times
        if (waitingTime > 0) {
            resetStartTime();
            waitingTime = std::max(0, waitingTime - (wallClock - oldWallClock));
        } else if (remainingTime > 0) {
            remainingTime = std::max(0, remainingTime - (wallClock - oldWallClock));
        }

        // React to end of waiting period
        if (programStatus == EOX6021Program::ProgramStatus::WAITING && waitingTime == 0) {
            programStatus = isAirHeatProgram ? EOX6021Program::ProgramStatus::PREHEATING : EOX6021Program::ProgramStatus::HEATING;
            currentMicrowavePower = microwaveOption->value();
        }

        // Check wethere there is time left in the program
        if (remainingTime == 0) {
            if (programStatus != EOX6021Program::ProgramStatus::DONE) {
                currentMicrowavePower = 0;
                programStatus = EOX6021Program::ProgramStatus::DONE;
            }
        } else if(programStatus != EOX6021Program::ProgramStatus::WAITING) {
            // Handle microwave power
            if (microwaveOption) {
                if (microwaveOption->isEnabled()) {
                    if (nextMicrowaveDegredationTime > 0 && m_backend->getWallClock() >= nextMicrowaveDegredationTime) {
                        currentMicrowavePower = degredationSteps[m_microwave_boost_degredation_index].degradedPower;
                        ++m_microwave_boost_degredation_index;
                    }
                }
                else {
                    currentMicrowavePower = 0;
                }
            }

            if (isAirHeatProgram) {
                // Update temperature if needed
                if (currentTemperature < targetTemperature) {
                    currentTemperature += heatingDelta;
                    currentTemperature = std::min(currentTemperature, targetTemperature);
                }

                // Explicitly set heating status thereby implicitly undoing a done status if necessary
                if (currentTemperature >= targetTemperature) {
                    if (currentTemperature > targetTemperature) {
                        currentTemperature = targetTemperature;
                    }
                    if (programStatus != EOX6021Program::ProgramStatus::HEATING) {
                        programStatus = EOX6021Program::ProgramStatus::HEATING;
                        if(programDefinition->getQuickHeat() && programDefinition->getQuickHeat()->isEnabled()) programDefinition->getQuickHeat()->setEnabled(false);
                        if(!program->getDefinition()->getIsMeal() && !program->getDefinition()->getIsCleaningProgram()) m_backend->triggerTemperatureReachedMessage();
                    }
                } else {
                    programStatus = EOX6021Program::ProgramStatus::PREHEATING;
                }
            }

            if (program->getDefinition()->getIsMeal() && wallClock == meal_flip_time) {
                m_backend->triggerMealFlipMessage();
            }
        }

        m_backend->setMicrowavePower(currentMicrowavePower);
        m_backend->setCurrentTemperature(currentTemperature);
        program->setWaitingTime(waitingTime);
        program->setRemainingTime(remainingTime);
        program->setStatus(programStatus);
    }

    m_backend->setWallClock(wallClock);
}

void OvenSimulation::resetStartTime()
{
    m_backend->getCurrentProgram()->setStartTime(m_backend->getWallClock());
}

void OvenSimulation::handleMicrowaveDefinitionChange() {
    EOX6021Program* program {m_backend->getCurrentProgram()};
    if (program && program->isHeating()) {
        EOX6021ProgramDefinition* programDefinition {program->getDefinition()};
        ProgramIntegerOption* microwaveOption {programDefinition->getMicrowave()};
        m_microwave_boost_degredation_index = 0;
        m_backend->setMicrowavePower(microwaveOption->isEnabled() ?microwaveOption->value() : 0);
    }
}

void OvenSimulation::startProgram()
{
    m_backend->setCurrentTemperature(21);
    m_backend->setMicrowavePower(0);
    EOX6021Program* program {m_backend->getCurrentProgram()};
    EOX6021ProgramDefinition* programDefinition {program->getDefinition()};
    resetStartTime();
    program->setWaitingTime(program->getInitialWaitingTime());
    initializeProgram();
    connect(programDefinition->getMicrowave(), SIGNAL(currentIndexChanged()), this, SLOT(handleMicrowaveDefinitionChange()));
    connect(programDefinition->getMicrowave(), SIGNAL(isEnabledChanged()), this, SLOT(handleMicrowaveDefinitionChange()));
    m_fastForwardRequested = false;
}

void OvenSimulation::resumeProgram()
{
    initializeProgram();
}

void OvenSimulation::initializeProgram()
{
    EOX6021Program* program {m_backend->getCurrentProgram()};
    EOX6021ProgramDefinition* programDefinition {program->getDefinition()};
    program->setRemainingTime(programDefinition->getDuration() && programDefinition->getDuration()->isEnabled() ? programDefinition->getDuration()->value() : -1);
    if(program->getWaitingTime() > 0) {
        program->setStatus(EOX6021Program::ProgramStatus::WAITING);
    } else {
        program->setStatus(programDefinition->getIsMicrowaveProgram() || m_backend->getCurrentTemperature() >= programDefinition->getTemperature()->value() ? EOX6021Program::ProgramStatus::HEATING : EOX6021Program::ProgramStatus::PREHEATING);
        auto microwaveOption = programDefinition->getMicrowave();
        if (microwaveOption) {
            m_backend->setMicrowavePower(microwaveOption->isEnabled() ? microwaveOption->value() : 0);
        }
    }
}

void OvenSimulation::terminateProgram()
{
    EOX6021Program* program {m_backend->getCurrentProgram()};
    m_backend->setMicrowavePower(0);
    m_microwave_boost_degredation_index = 0;
    if (program) {
        EOX6021ProgramDefinition* programDefinition {program->getDefinition()};
        program->setStatus(EOX6021Program::ProgramStatus::TERMINATED);
        programDefinition->getMicrowave()->disconnect(this);
    }
}

void OvenSimulation::fastForward()
{
    m_fastForwardRequested = true;
}

}
