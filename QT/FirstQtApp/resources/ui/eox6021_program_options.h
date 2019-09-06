#ifndef EOX6021_PROGRAM_OPTIONS_H
#define EOX6021_PROGRAM_OPTIONS_H

#include <QString>
#include <QObject>
#include <QList>
#include <iostream>

namespace BSH
{

class ProgramOption : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool isEnabled READ isEnabled WRITE setEnabled NOTIFY isEnabledChanged)
    Q_PROPERTY(bool isDeactivated READ isDeactivated WRITE setDeactivated NOTIFY isDeactivatedChanged)
    Q_PROPERTY(bool isInAlternativeMode READ isInAlternativeMode WRITE setInAlternativeMode NOTIFY isInAlternativeModeChanged)

signals:
    void isEnabledChanged();
    void isDeactivatedChanged();
    void isInAlternativeModeChanged();

public:
    explicit ProgramOption(QObject *parent = nullptr) :
        QObject(parent)
    {}

    ProgramOption& operator=(ProgramOption& option)
    {
        m_isEnabled = option.m_isEnabled;
        emit isEnabledChanged();
        m_isDeactivated = option.m_isDeactivated;
        emit isDeactivatedChanged();
        m_isInAlternativeMode = option.m_isInAlternativeMode;
        emit isInAlternativeModeChanged();
        return *this;
    }

    bool inline operator != (const ProgramOption& option) const
    {
        return (option.m_isEnabled != m_isEnabled) ||
               (option.m_isDeactivated != m_isDeactivated) ||
               (option.m_isInAlternativeMode != m_isInAlternativeMode);
    }

    bool isDeactivated()
    {
        return m_isDeactivated;
    }

    void setDeactivated(bool value)
    {
        if (m_isDeactivated != value) {
            m_isDeactivated = value;
            emit isDeactivatedChanged();
            if (m_isDeactivated) {
                setEnabled(false);
                setInAlternativeMode(false);
            }
        }
    }

    bool isEnabled()
    {
        return m_isEnabled;
    }

    void setEnabled(bool value)
    {
        if (m_isEnabled != value) {
            m_isEnabled = value;
            emit isEnabledChanged();
            if (m_isEnabled && m_isInAlternativeMode) {
                m_isInAlternativeMode = false;
                emit isInAlternativeModeChanged();
            }
        }
    }

    bool isInAlternativeMode()
    {
        return m_isInAlternativeMode;
    }

    void setInAlternativeMode(bool value)
    {
        if (m_isInAlternativeMode != value) {
            m_isInAlternativeMode = value;
            emit isInAlternativeModeChanged();
            if (m_isEnabled && m_isInAlternativeMode) {
                m_isEnabled = false;
                emit isEnabledChanged();
            }
        }
    }

    bool m_isEnabled {true};
    bool m_isDeactivated {false};
    bool m_isInAlternativeMode {false};
};

class ProgramIntegerIntervalOption : public ProgramOption
{
    Q_OBJECT

    Q_PROPERTY(int startingValue MEMBER m_startingValue NOTIFY startingValueChanged)
    Q_PROPERTY(int intervalLength MEMBER m_intervalLength NOTIFY intervalLengthChanged)
    Q_PROPERTY(int intervalCount MEMBER m_intervalCount NOTIFY intervalCountChanged)
    Q_PROPERTY(int intervalIndex MEMBER m_intervalIndex NOTIFY intervalIndexChanged)


signals:
    void startingValueChanged();
    void intervalLengthChanged();
    void intervalCountChanged();
    void intervalIndexChanged();

public:
    using ProgramOption::ProgramOption;

    ProgramIntegerIntervalOption& operator=(ProgramIntegerIntervalOption& option)
    {
        ProgramOption::operator=(option);
        m_startingValue = option.m_startingValue;
        emit startingValueChanged();
        m_intervalLength = option.m_intervalLength;
        emit intervalLengthChanged();
        m_intervalCount = option.m_intervalCount;
        emit intervalCountChanged();
        m_intervalIndex = option.m_intervalIndex;
        emit intervalIndexChanged();
        return *this;
    }

    bool inline operator != (const ProgramIntegerIntervalOption& option) const {
        return ProgramOption::operator !=(option) ||
               (option.m_intervalIndex != m_intervalIndex) ||
               (option.m_startingValue != m_startingValue) ||
               (option.m_intervalLength != m_intervalLength) ||
               (option.m_intervalCount != m_intervalCount);
    }

    Q_INVOKABLE int value() {
        return m_startingValue + m_intervalIndex * m_intervalLength;
    }

    int m_startingValue {0};
    int m_intervalLength {0};
    int m_intervalCount {0};
    int m_intervalIndex {0};
};

class ProgramIntegerOption : public ProgramOption
{
    Q_OBJECT

    Q_PROPERTY(int currentIndex MEMBER m_currentIndex NOTIFY currenIndexChanged)
    Q_PROPERTY(QList<int> options MEMBER m_options NOTIFY optionsChanged)

signals:
    void currenIndexChanged();
    void optionsChanged();

public:
    using ProgramOption::ProgramOption;

    ProgramIntegerOption& operator =(ProgramIntegerOption& option)
    {
        ProgramOption::operator=(option);
        m_currentIndex = option.m_currentIndex;
        emit currenIndexChanged();
        m_options = option.m_options;
        emit optionsChanged();
        return *this;
    }

    bool inline operator != (const ProgramIntegerOption& option) const {
            return ProgramOption::operator !=(option) ||
                   (option.m_currentIndex != m_currentIndex) ||
                   (option.m_options != m_options);
    }

    int m_currentIndex {0};
    QList<int> m_options {};
};

class ProgramStringOption : public ProgramOption
{
    Q_OBJECT

    Q_PROPERTY(int currentIndex MEMBER m_currentIndex NOTIFY currenIndexChanged)
    Q_PROPERTY(QList<QString> options MEMBER m_options NOTIFY optionsChanged)

signals:
    void currenIndexChanged();
    void optionsChanged();

public:
    using ProgramOption::ProgramOption;

    ProgramStringOption& operator =(ProgramStringOption& option)
    {
        ProgramOption::operator=(option);
        m_currentIndex = option.m_currentIndex;
        emit currenIndexChanged();
        m_options = option.m_options;
        emit optionsChanged();
        return *this;
    }

    bool inline operator != (const ProgramStringOption& option) const {
            return ProgramOption::operator !=(option) ||
                   (option.m_currentIndex != m_currentIndex) ||
                   (option.m_options != m_options);
    }

    int m_currentIndex {0};
    QList<QString> m_options {};
};

class ProgramBooleanOption : public ProgramOption
{
    Q_OBJECT

public:
    using ProgramOption::ProgramOption;

    bool inline operator !=(const ProgramBooleanOption& option) const {
        return ProgramOption::operator !=(option);
    }

    Q_INVOKABLE bool value() {
        return m_isEnabled;
    }
};


}

#endif // EOX6021_PROGRAM_OPTIONS_H
