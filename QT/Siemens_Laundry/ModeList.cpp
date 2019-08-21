#include "ModeList.h"

ModeList::ModeList(QObject *parent) : QObject(parent)
{
//    QVector<Program> washProgram;
//    Program *cotton = new Program("Cotton", "60, 2h30m", "res/icon/Program-img.png");
//    Program *easycare = new Program("Easy care", "40, 1h30m", "res/icon/Program-img.png");
//    Program *mix = new Program("Mix", "40, 1h45m", "res/icon/Program-img.png");

//    washProgram.append(*cotton);
//    washProgram.append(*easycare);
//    washProgram.append(*mix);

//    _modeItem.append({QStringLiteral("Wash"),QStringLiteral("Wash mode"), washProgram});
//    _modeItem.append({QStringLiteral("Wash & Dry"),QStringLiteral("Wash & Dry mode"), washProgram});
//    _modeItem.append({QStringLiteral("Dry"),QStringLiteral("Dry mode"), washProgram});

        _modeItem.append({true,QStringLiteral("Wash mode")});
        _modeItem.append({false,QStringLiteral("Wash & Dry mode")});
        _modeItem.append({true,QStringLiteral("Dry mode")});
//        _modeItem.append({true,QStringLiteral("Dry mode")});
//        _modeItem.append({true,QStringLiteral("Dry mode")});
//        _modeItem.append({true,QStringLiteral("Dry mode")});
//        _modeItem.append({true,QStringLiteral("Dry mode")});
}

QVector<ModeItem> ModeList::items() const
{
    return _modeItem;
}

