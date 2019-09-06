#include "eox6021_backend.h"
#include <QSettings>
#include <QFileInfo>

namespace BSH
{

EOX6021BackEnd::EOX6021BackEnd(QObject *parent) :
    QObject(parent)
{
    m_testOption = new ProgramBooleanOption(this);
    m_displayBrightness = new ProgramStringOption(this);
    m_displayBrightness->m_options = {"1", "2", "3", "4", "5"};
    m_displayBrightness->m_currentIndex = 2;
    m_standbyClockMode = new ProgramStringOption(this);
    m_standbyClockMode->m_options = {"aus", "digital", "analog"};
    m_standbyClockMode->m_currentIndex = 1;

    m_wallClock = QTime::currentTime().msecsSinceStartOfDay() / 1000;
    m_currentDate = QDateTime::currentDateTime().toString("dddd, dd.MM.");

    // Read configuration
    QSettings modeSettings(QFileInfo("resources/mode.ini").absoluteFilePath(), QSettings::IniFormat);
    QString mode(modeSettings.value("mode").toString());
    if(QString::compare(mode, "siemens", Qt::CaseInsensitive) == 0) {
        m_microwave_boost_degredation_steps = {{60, 800}, {30, 700}, {30, 600}};
    }
    else {
        qWarning() << "Unknown Mode: " << mode;
    }



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
    // terminate old program
    if (m_currentProgram) {
        m_currentProgram->terminate();
        while (m_currentProgram->getStatus() != EOX6021Program::ProgramStatus::TERMINATED) {
            QThread::msleep(10);
        }
    }

    if(programDefinition != nullptr) {
        EOX6021Program* oldProgram {m_currentProgram};
        m_currentProgram = new EOX6021Program(getProgramDefinitionCopy(programDefinition), this);
        connect(m_currentProgram, &EOX6021Program::start, ovenSimulation, &OvenSimulation::startProgram, Qt::QueuedConnection);
        connect(m_currentProgram, &EOX6021Program::resume, ovenSimulation, &OvenSimulation::resumeProgram, Qt::QueuedConnection);
        connect(m_currentProgram, &EOX6021Program::terminate, ovenSimulation, &OvenSimulation::terminateProgram, Qt::QueuedConnection);
        if (oldProgram) oldProgram->deleteLater();
    }

    emit currentProgramChanged();
}

void EOX6021BackEnd::turnOff() {
    setCurrentProgramFromDefinition(nullptr);
}

void EOX6021BackEnd::setAlarm(int duration) {
    m_alarmTime = m_wallClock + duration;
    alarmTimeChanged();
}

void EOX6021BackEnd::setAlarmIndex(int value) {
    m_alarmIndex = value;
    emit alarmIndexChanged();
}

int EOX6021BackEnd::getAlarmIndex(){
    return m_alarmIndex;
}

void EOX6021BackEnd::setAlarmResetTime(int value) {
    m_alarmResetTime = value;
    emit alarmResetTimeChanged();
}

int EOX6021BackEnd::getAlarmResetTime(){
    return m_alarmResetTime;
}

}
