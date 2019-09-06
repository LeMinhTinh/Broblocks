#include "eox6021_oven_simulation.h"
#include <QDateTime>

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
    if (program) {
        EOX6021Program::ProgramStatus programStatus {program->getStatus()};
        int remainingTime {program->getRemainingTime()};

        // Only run simulation steps for started programs
        if (programStatus != EOX6021Program::ProgramStatus::IDLING) {
            EOX6021ProgramDefinition* programDefinition {program->getDefinition()};
            qreal currentTemperature {m_backend->getCurrentTemperature()};
            qreal currentSpinSpeed {m_backend->getCurrentSpinSpeed()};
            qreal targetTemperature {static_cast<qreal>(programDefinition->getTemperature()->value())};
            qreal targetSpinSpeed {static_cast<qreal>(programDefinition->getSpinSpeed()->value())};
            bool useQuickHeat {programDefinition->getQuickHeat() ? programDefinition->getQuickHeat()->isEnabled() : false};
            qreal heatingDelta {useQuickHeat ? degreePerSecondQuickHeating : degreePerSecondNormalHeating};

            // Advance time and according to that temperture if requested
            if (m_fastForwardRequested) {
                int wallClockDelta {0};
                int durationEventTime {0};
                if (remainingTime >= 0) {
                    durationEventTime = wallClock + remainingTime - 5;
                }
                if (programStatus == EOX6021Program::ProgramStatus::PREHEATING) {
                    int eventTime {wallClock - 6 + static_cast<int>(std::ceil((targetTemperature - currentTemperature) / heatingDelta))};
                    if (durationEventTime && eventTime > durationEventTime) eventTime = durationEventTime;
                    if (eventTime > wallClock) {
                        wallClockDelta = eventTime - wallClock;
                    }
                } else if (programStatus == EOX6021Program::ProgramStatus::HEATING && durationEventTime > wallClock) {
                    wallClockDelta = durationEventTime - wallClock;
                }

                wallClock += wallClockDelta;
                currentTemperature += heatingDelta * wallClockDelta;
                currentSpinSpeed += heatingDelta * wallClockDelta;
                currentTemperature = std::min(currentTemperature, targetTemperature);
                currentSpinSpeed = std::min(currentSpinSpeed, targetSpinSpeed);
                m_backend->setCurrentTemperature(currentTemperature);
                m_backend->setCurrentSpinSpeed(currentSpinSpeed);
                m_fastForwardRequested = false;
            }

            // Check wethere there is time left in the program
            if (remainingTime == 0) {
                if (programStatus != EOX6021Program::ProgramStatus::DONE) {
                    program->setStatus(EOX6021Program::ProgramStatus::DONE);
                }
            } else {
                // Update temperature if needed
                if (currentTemperature < targetTemperature) {
                    currentTemperature += heatingDelta;
                    currentTemperature = std::min(currentTemperature, targetTemperature);
                    m_backend->setCurrentTemperature(currentTemperature);
                }

                // Explicitly set heating status thereby implicitly undoing a done status if necessary
                if (currentTemperature >= targetTemperature) {
                    if (programStatus != EOX6021Program::ProgramStatus::HEATING) {
                        if (programStatus != EOX6021Program::ProgramStatus::PAUSE)
                        {
                            program->setStatus(EOX6021Program::ProgramStatus::HEATING);
                        }
                    }
                    if (currentTemperature > targetTemperature) {
                        m_backend->setCurrentTemperature(targetTemperature);
                    }
                } else if (programStatus != EOX6021Program::ProgramStatus::PREHEATING) {
                    if (programStatus != EOX6021Program::ProgramStatus::PAUSE) {
                        program->setStatus(EOX6021Program::ProgramStatus::PREHEATING);
                    }
                }
            }
        }

        if (remainingTime >= 0) program->setRemainingTime(std::max(0, remainingTime - (wallClock - oldWallClock)));
    }

    m_backend->setWallClock(wallClock);
}

void OvenSimulation::resetStartTime()
{
    m_backend->getCurrentProgram()->setStartTime(m_backend->getWallClock());
}

void OvenSimulation::startProgram()
{
    m_backend->setCurrentTemperature(30);
    m_backend->setCurrentSpinSpeed(800);
    EOX6021Program* program {m_backend->getCurrentProgram()};
    EOX6021ProgramDefinition* programDefinition {program->getDefinition()};
    resetStartTime();
    program->setRemainingTime(programDefinition->getDuration() && programDefinition->getDuration()->isEnabled() ? programDefinition->getDuration()->value() * 60 : -1);
    program->setStatus(EOX6021Program::ProgramStatus::PREHEATING);
}

void OvenSimulation::terminateProgram()
{
    EOX6021Program* program {m_backend->getCurrentProgram()};
    if (program) program->setStatus(EOX6021Program::ProgramStatus::IDLING);
}

void OvenSimulation::pauseProgram()
{
    EOX6021Program* program {m_backend->getCurrentProgram()};
    if (program) program->setStatus(EOX6021Program::ProgramStatus::PAUSE);
}

void OvenSimulation::fastForward()
{
    m_fastForwardRequested = true;
}

}
