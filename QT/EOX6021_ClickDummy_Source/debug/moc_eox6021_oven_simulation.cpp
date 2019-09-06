/****************************************************************************
** Meta object code from reading C++ file 'eox6021_oven_simulation.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../eox6021_oven_simulation.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'eox6021_oven_simulation.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_BSH__OvenSimulation_t {
    QByteArrayData data[10];
    char stringdata0[145];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__OvenSimulation_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__OvenSimulation_t qt_meta_stringdata_BSH__OvenSimulation = {
    {
QT_MOC_LITERAL(0, 0, 19), // "BSH::OvenSimulation"
QT_MOC_LITERAL(1, 20, 5), // "start"
QT_MOC_LITERAL(2, 26, 0), // ""
QT_MOC_LITERAL(3, 27, 13), // "resumeProgram"
QT_MOC_LITERAL(4, 41, 12), // "startProgram"
QT_MOC_LITERAL(5, 54, 16), // "terminateProgram"
QT_MOC_LITERAL(6, 71, 11), // "fastForward"
QT_MOC_LITERAL(7, 83, 14), // "resetStartTime"
QT_MOC_LITERAL(8, 98, 14), // "simulationStep"
QT_MOC_LITERAL(9, 113, 31) // "handleMicrowaveDefinitionChange"

    },
    "BSH::OvenSimulation\0start\0\0resumeProgram\0"
    "startProgram\0terminateProgram\0fastForward\0"
    "resetStartTime\0simulationStep\0"
    "handleMicrowaveDefinitionChange"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__OvenSimulation[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x0a /* Public */,
       3,    0,   55,    2, 0x0a /* Public */,
       4,    0,   56,    2, 0x0a /* Public */,
       5,    0,   57,    2, 0x0a /* Public */,
       6,    0,   58,    2, 0x0a /* Public */,
       7,    0,   59,    2, 0x0a /* Public */,
       8,    0,   60,    2, 0x08 /* Private */,
       9,    0,   61,    2, 0x08 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void BSH::OvenSimulation::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<OvenSimulation *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->start(); break;
        case 1: _t->resumeProgram(); break;
        case 2: _t->startProgram(); break;
        case 3: _t->terminateProgram(); break;
        case 4: _t->fastForward(); break;
        case 5: _t->resetStartTime(); break;
        case 6: _t->simulationStep(); break;
        case 7: _t->handleMicrowaveDefinitionChange(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject BSH::OvenSimulation::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_BSH__OvenSimulation.data,
    qt_meta_data_BSH__OvenSimulation,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::OvenSimulation::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::OvenSimulation::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__OvenSimulation.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int BSH::OvenSimulation::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
