#ifndef EOX6021_OVEN_SIMULATION_H
#define EOX6021_OVEN_SIMULATION_H

#include <QObject>
#include <cstddef>

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
    void resumeProgram();
    void startProgram();
    void terminateProgram();
    void fastForward();
    void resetStartTime();

private slots:
    void simulationStep();
    void handleMicrowaveDefinitionChange();

private:
    void initializeProgram();

    EOX6021BackEnd* m_backend;
    bool m_fastForwardRequested {false};
    std::size_t m_microwave_boost_degredation_index{0};
};

}

#endif // EOX6021_OVEN_SIMULATION_H
