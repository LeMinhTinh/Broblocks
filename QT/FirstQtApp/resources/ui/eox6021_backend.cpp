#include "eox6021_backend.h"

namespace BSH
{

EOX6021BackEnd::EOX6021BackEnd(QObject *parent) :
    QObject(parent)
{
    m_wallClock = QTime::currentTime().msecsSinceStartOfDay() / 1000;

    ovenSimulation = new OvenSimulation(this);
    ovenSimulation->moveToThread(&simulationThread);
    connect(&simulationThread, &QThread::finished, ovenSimulation, &QObject::deleteLater);
    simulationThread.start();
    QMetaObject::invokeMethod(ovenSimulation, "start");

    connect(this, &EOX6021BackEnd::fastForward, ovenSimulation, &OvenSimulation::fastForward, Qt::DirectConnection);
}

EOX6021BackEnd::~EOX6021BackEnd() {
    simulationThread.quit();
    simulationThread.wait();
}

EOX6021ProgramDefinition* EOX6021BackEnd::getProgramDefinitionCopy(EOX6021ProgramDefinition* programDefinition)
{
    EOX6021ProgramDefinition *newProgramDefinition {new EOX6021ProgramDefinition(this)};
    newProgramDefinition->fetchDefinition(programDefinition);
    return newProgramDefinition;
}

void EOX6021BackEnd::setCurrentProgramFromDefinition(EOX6021ProgramDefinition* programDefinition)
{
    // terminate and remove old program
    if (m_currentProgram) {
        m_currentProgram->terminate();
        // TODO This possibly infinite busy loop a bad but practical solution for now
        while (m_currentProgram->getStatus() != EOX6021Program::ProgramStatus::IDLING) {
            QThread::msleep(10);
        }
        m_currentProgram->deleteLater();
        m_currentProgram = nullptr;
    }

    m_currentProgram = new EOX6021Program(getProgramDefinitionCopy(programDefinition), this);
    connect(m_currentProgram, &EOX6021Program::start, ovenSimulation, &OvenSimulation::startProgram, Qt::QueuedConnection);
    connect(m_currentProgram, &EOX6021Program::terminate, ovenSimulation, &OvenSimulation::terminateProgram, Qt::QueuedConnection);
    connect(m_currentProgram, &EOX6021Program::pause, ovenSimulation, &OvenSimulation::pauseProgram, Qt::QueuedConnection);
    connect(m_currentProgram, &EOX6021Program::remainingTimeInitialized, ovenSimulation, &OvenSimulation::resetStartTime, Qt::QueuedConnection);
    emit currentProgramChanged();
}

void EOX6021BackEnd::turnOff() {
    if (m_currentProgram) m_currentProgram->terminate();
}

}
