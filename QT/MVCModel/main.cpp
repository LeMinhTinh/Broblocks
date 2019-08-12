#include <QApplication>
#include "view.h"
#include "model.h"
#include "controller.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    Model model;
    View window;
    Controller ctrl(&model);
    window.setController(&ctrl);
    window.show();
    return app.exec();
}
