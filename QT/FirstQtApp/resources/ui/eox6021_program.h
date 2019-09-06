#ifndef EOX6021_PROGRAM_H
#define EOX6021_PROGRAM_H

#include <QObject>
#include <QThread>

#include "eox6021_program_definition.h"

namespace BSH
{

class EOX6021Program : public QObject
{
    Q_OBJECT

    Q_PROPERTY(EOX6021ProgramDefinition* definition READ getDefinition WRITE setDefinition NOTIFY definitionChanged)
    Q_PROPERTY(ProgramStatus status READ getStatus WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(int startTime READ getStartTime WRITE setStartTime NOTIFY startTimeChanged)
    Q_PROPERTY(int remainingTime READ getRemainingTime WRITE setRemainingTime NOTIFY remainingTimeChanged)
    Q_PROPERTY(ProgramIntegerIntervalOption* endTime READ getEndTime WRITE setEndTime NOTIFY endTimeChanged)

public:
    enum class ProgramStatus
    {
        IDLING,
        PAUSE,
        PREHEATING,
        HEATING,
        DONE
    };
    Q_ENUM(ProgramStatus)

    explicit EOX6021Program(QObject *parent = nullptr) :
        EOX6021Program(new EOX6021ProgramDefinition(this), parent)
    {}

    explicit EOX6021Program(EOX6021ProgramDefinition* programDefinition, QObject *parent):
        QObject(parent)
    {
        setEndTime(new ProgramIntegerIntervalOption(this));
        m_endTime->setProperty("intervalLength", 5);
        m_endTime->setProperty("intervalCount", 36);
        setDefinition(programDefinition);
    }

    EOX6021ProgramDefinition* getDefinition()
    {
        return m_definition;
    }

    void setDefinition(EOX6021ProgramDefinition* value)
    {
        m_definition = value;

        if (m_definition) {
            connect(m_definition->getDuration(), &ProgramOption::isEnabledChanged, this, &EOX6021Program::handleDurationStatus, Qt::DirectConnection);
            handleDurationStatus();
        }

        emit definitionChanged();
    }

    ProgramStatus getStatus()
    {
        return m_status;
    }

    void setStatus(ProgramStatus value)
    {
        m_status = value;
        emit statusChanged();
    }

    int getStartTime()
    {
        return m_startTime;
    }

    void setStartTime(int value)
    {
        m_startTime = value;
        emit startTimeChanged();
    }

    int getRemainingTime()
    {
        return m_remainingTime;
    }

    void setRemainingTime(int value)
    {
        if (m_remainingTime < 0) {
            m_remainingTime = value;
            emit remainingTimeInitialized();
        } else {
            m_remainingTime = value;
        }
        emit remainingTimeChanged();
    }

    ProgramIntegerIntervalOption* getEndTime() {
        return m_endTime;
    }

    void handleDurationStatus() {
        if (m_definition->getDuration() && m_definition->getDuration()->isEnabled()) {
            if (m_endTime) m_endTime->setProperty("isDeactivated", false);
        } else {
            if (m_endTime) m_endTime->setProperty("isDeactivated", true);
            if (m_endTime) m_endTime->setProperty("isEnabled", false);
            if (m_endTime) m_endTime->setProperty("intervalIndex", 0);
        }
    }

    void setEndTime(ProgramIntegerIntervalOption* option) {
        m_endTime = option;
        if (!m_definition || !m_definition->getDuration() || !m_definition->getDuration()->isEnabled()) {
            if (m_endTime) m_endTime->setProperty("isDeactivated", true);
            if (m_endTime) m_endTime->setProperty("isEnabled", false);
            if (m_endTime) m_endTime->setProperty("intervalIndex", 0);
        }
        emit endTimeChanged();
    }

    ~EOX6021Program()
    {}

signals:
    void definitionChanged();
    void statusChanged();
    void startTimeChanged();
    void remainingTimeChanged();
    void remainingTimeInitialized();
    void start();
    void terminate();
    void pause();
    void endTimeChanged();

private:
    EOX6021ProgramDefinition* m_definition {};
    int m_startTime {0};
    int m_remainingTime {-1};
    ProgramStatus m_status {ProgramStatus::IDLING};
    ProgramIntegerIntervalOption* m_endTime;
};

}

#endif // EOX6021_PROGRAM_H
