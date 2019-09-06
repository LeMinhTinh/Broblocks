#ifndef EOX6021_OVEN_SIMULATION_H
#define EOX6021_OVEN_SIMULATION_H

#include <QObject>

#include "eox6021_backend.h"

namespace BSH
{

class EOX6021BackEnd;

class OvenSimulation : public QObject
{
    Q_OBJECT
    const qreal degreePerSecondNormalHeating {0.3};
    const qreal degreePerSecondQuickHeating {0.6};

public:
    explicit OvenSimulation(EOX6021BackEnd *backend);

public slots:
    void start();
    void startProgram();
    void terminateProgram();
    void pauseProgram();
    void fastForward();
    void resetStartTime();

private slots:
    void simulationStep();

private:
    EOX6021BackEnd* m_backend;
    bool m_fastForwardRequested {false};
};

}

#endif // EOX6021_OVEN_SIMULATION_H
