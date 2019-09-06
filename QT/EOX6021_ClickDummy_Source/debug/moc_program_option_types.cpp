/****************************************************************************
** Meta object code from reading C++ file 'program_option_types.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../program_option_types.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QList>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'program_option_types.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_BSH__ProgramOption_t {
    QByteArrayData data[8];
    char stringdata0[129];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__ProgramOption_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__ProgramOption_t qt_meta_stringdata_BSH__ProgramOption = {
    {
QT_MOC_LITERAL(0, 0, 18), // "BSH::ProgramOption"
QT_MOC_LITERAL(1, 19, 16), // "isEnabledChanged"
QT_MOC_LITERAL(2, 36, 0), // ""
QT_MOC_LITERAL(3, 37, 20), // "isDeactivatedChanged"
QT_MOC_LITERAL(4, 58, 26), // "isInAlternativeModeChanged"
QT_MOC_LITERAL(5, 85, 9), // "isEnabled"
QT_MOC_LITERAL(6, 95, 13), // "isDeactivated"
QT_MOC_LITERAL(7, 109, 19) // "isInAlternativeMode"

    },
    "BSH::ProgramOption\0isEnabledChanged\0"
    "\0isDeactivatedChanged\0isInAlternativeModeChanged\0"
    "isEnabled\0isDeactivated\0isInAlternativeMode"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__ProgramOption[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       3,   32, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   29,    2, 0x06 /* Public */,
       3,    0,   30,    2, 0x06 /* Public */,
       4,    0,   31,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       5, QMetaType::Bool, 0x00495003,
       6, QMetaType::Bool, 0x00495003,
       7, QMetaType::Bool, 0x00495003,

 // properties: notify_signal_id
       0,
       1,
       2,

       0        // eod
};

void BSH::ProgramOption::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ProgramOption *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->isEnabledChanged(); break;
        case 1: _t->isDeactivatedChanged(); break;
        case 2: _t->isInAlternativeModeChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ProgramOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramOption::isEnabledChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ProgramOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramOption::isDeactivatedChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ProgramOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramOption::isInAlternativeModeChanged)) {
                *result = 2;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ProgramOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->isEnabled(); break;
        case 1: *reinterpret_cast< bool*>(_v) = _t->isDeactivated(); break;
        case 2: *reinterpret_cast< bool*>(_v) = _t->isInAlternativeMode(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<ProgramOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setEnabled(*reinterpret_cast< bool*>(_v)); break;
        case 1: _t->setDeactivated(*reinterpret_cast< bool*>(_v)); break;
        case 2: _t->setInAlternativeMode(*reinterpret_cast< bool*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject BSH::ProgramOption::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_BSH__ProgramOption.data,
    qt_meta_data_BSH__ProgramOption,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::ProgramOption::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::ProgramOption::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__ProgramOption.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int BSH::ProgramOption::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void BSH::ProgramOption::isEnabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BSH::ProgramOption::isDeactivatedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void BSH::ProgramOption::isInAlternativeModeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
struct qt_meta_stringdata_BSH__ProgramIntegerIntervalOption_t {
    QByteArrayData data[12];
    char stringdata0[192];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__ProgramIntegerIntervalOption_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__ProgramIntegerIntervalOption_t qt_meta_stringdata_BSH__ProgramIntegerIntervalOption = {
    {
QT_MOC_LITERAL(0, 0, 33), // "BSH::ProgramIntegerIntervalOp..."
QT_MOC_LITERAL(1, 34, 20), // "startingValueChanged"
QT_MOC_LITERAL(2, 55, 0), // ""
QT_MOC_LITERAL(3, 56, 21), // "intervalLengthChanged"
QT_MOC_LITERAL(4, 78, 20), // "intervalCountChanged"
QT_MOC_LITERAL(5, 99, 20), // "intervalIndexChanged"
QT_MOC_LITERAL(6, 120, 5), // "value"
QT_MOC_LITERAL(7, 126, 8), // "setValue"
QT_MOC_LITERAL(8, 135, 13), // "startingValue"
QT_MOC_LITERAL(9, 149, 14), // "intervalLength"
QT_MOC_LITERAL(10, 164, 13), // "intervalCount"
QT_MOC_LITERAL(11, 178, 13) // "intervalIndex"

    },
    "BSH::ProgramIntegerIntervalOption\0"
    "startingValueChanged\0\0intervalLengthChanged\0"
    "intervalCountChanged\0intervalIndexChanged\0"
    "value\0setValue\0startingValue\0"
    "intervalLength\0intervalCount\0intervalIndex"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__ProgramIntegerIntervalOption[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       4,   52, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x06 /* Public */,
       3,    0,   45,    2, 0x06 /* Public */,
       4,    0,   46,    2, 0x06 /* Public */,
       5,    0,   47,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       6,    0,   48,    2, 0x02 /* Public */,
       7,    1,   49,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,    6,

 // properties: name, type, flags
       8, QMetaType::Int, 0x00495003,
       9, QMetaType::Int, 0x00495003,
      10, QMetaType::Int, 0x00495003,
      11, QMetaType::Int, 0x00495003,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,

       0        // eod
};

void BSH::ProgramIntegerIntervalOption::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ProgramIntegerIntervalOption *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->startingValueChanged(); break;
        case 1: _t->intervalLengthChanged(); break;
        case 2: _t->intervalCountChanged(); break;
        case 3: _t->intervalIndexChanged(); break;
        case 4: { int _r = _t->value();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->setValue((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ProgramIntegerIntervalOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramIntegerIntervalOption::startingValueChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ProgramIntegerIntervalOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramIntegerIntervalOption::intervalLengthChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ProgramIntegerIntervalOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramIntegerIntervalOption::intervalCountChanged)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (ProgramIntegerIntervalOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramIntegerIntervalOption::intervalIndexChanged)) {
                *result = 3;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ProgramIntegerIntervalOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->m_startingValue; break;
        case 1: *reinterpret_cast< int*>(_v) = _t->m_intervalLength; break;
        case 2: *reinterpret_cast< int*>(_v) = _t->m_intervalCount; break;
        case 3: *reinterpret_cast< int*>(_v) = _t->m_intervalIndex; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<ProgramIntegerIntervalOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_startingValue != *reinterpret_cast< int*>(_v)) {
                _t->m_startingValue = *reinterpret_cast< int*>(_v);
                Q_EMIT _t->startingValueChanged();
            }
            break;
        case 1:
            if (_t->m_intervalLength != *reinterpret_cast< int*>(_v)) {
                _t->m_intervalLength = *reinterpret_cast< int*>(_v);
                Q_EMIT _t->intervalLengthChanged();
            }
            break;
        case 2:
            if (_t->m_intervalCount != *reinterpret_cast< int*>(_v)) {
                _t->m_intervalCount = *reinterpret_cast< int*>(_v);
                Q_EMIT _t->intervalCountChanged();
            }
            break;
        case 3:
            if (_t->m_intervalIndex != *reinterpret_cast< int*>(_v)) {
                _t->m_intervalIndex = *reinterpret_cast< int*>(_v);
                Q_EMIT _t->intervalIndexChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject BSH::ProgramIntegerIntervalOption::staticMetaObject = { {
    &ProgramOption::staticMetaObject,
    qt_meta_stringdata_BSH__ProgramIntegerIntervalOption.data,
    qt_meta_data_BSH__ProgramIntegerIntervalOption,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::ProgramIntegerIntervalOption::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::ProgramIntegerIntervalOption::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__ProgramIntegerIntervalOption.stringdata0))
        return static_cast<void*>(this);
    return ProgramOption::qt_metacast(_clname);
}

int BSH::ProgramIntegerIntervalOption::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = ProgramOption::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void BSH::ProgramIntegerIntervalOption::startingValueChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BSH::ProgramIntegerIntervalOption::intervalLengthChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void BSH::ProgramIntegerIntervalOption::intervalCountChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void BSH::ProgramIntegerIntervalOption::intervalIndexChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
struct qt_meta_stringdata_BSH__ProgramIntegerOption_t {
    QByteArrayData data[8];
    char stringdata0[100];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__ProgramIntegerOption_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__ProgramIntegerOption_t qt_meta_stringdata_BSH__ProgramIntegerOption = {
    {
QT_MOC_LITERAL(0, 0, 25), // "BSH::ProgramIntegerOption"
QT_MOC_LITERAL(1, 26, 19), // "currentIndexChanged"
QT_MOC_LITERAL(2, 46, 0), // ""
QT_MOC_LITERAL(3, 47, 14), // "optionsChanged"
QT_MOC_LITERAL(4, 62, 5), // "value"
QT_MOC_LITERAL(5, 68, 12), // "currentIndex"
QT_MOC_LITERAL(6, 81, 7), // "options"
QT_MOC_LITERAL(7, 89, 10) // "QList<int>"

    },
    "BSH::ProgramIntegerOption\0currentIndexChanged\0"
    "\0optionsChanged\0value\0currentIndex\0"
    "options\0QList<int>"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__ProgramIntegerOption[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       2,   32, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   29,    2, 0x06 /* Public */,
       3,    0,   30,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       4,    0,   31,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Int,

 // properties: name, type, flags
       5, QMetaType::Int, 0x00495003,
       6, 0x80000000 | 7, 0x0049500b,

 // properties: notify_signal_id
       0,
       1,

       0        // eod
};

void BSH::ProgramIntegerOption::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ProgramIntegerOption *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->currentIndexChanged(); break;
        case 1: _t->optionsChanged(); break;
        case 2: { int _r = _t->value();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ProgramIntegerOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramIntegerOption::currentIndexChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ProgramIntegerOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramIntegerOption::optionsChanged)) {
                *result = 1;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ProgramIntegerOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->m_currentIndex; break;
        case 1: *reinterpret_cast< QList<int>*>(_v) = _t->m_options; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<ProgramIntegerOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_currentIndex != *reinterpret_cast< int*>(_v)) {
                _t->m_currentIndex = *reinterpret_cast< int*>(_v);
                Q_EMIT _t->currentIndexChanged();
            }
            break;
        case 1:
            if (_t->m_options != *reinterpret_cast< QList<int>*>(_v)) {
                _t->m_options = *reinterpret_cast< QList<int>*>(_v);
                Q_EMIT _t->optionsChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject BSH::ProgramIntegerOption::staticMetaObject = { {
    &ProgramOption::staticMetaObject,
    qt_meta_stringdata_BSH__ProgramIntegerOption.data,
    qt_meta_data_BSH__ProgramIntegerOption,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::ProgramIntegerOption::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::ProgramIntegerOption::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__ProgramIntegerOption.stringdata0))
        return static_cast<void*>(this);
    return ProgramOption::qt_metacast(_clname);
}

int BSH::ProgramIntegerOption::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = ProgramOption::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void BSH::ProgramIntegerOption::currentIndexChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BSH::ProgramIntegerOption::optionsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
struct qt_meta_stringdata_BSH__ProgramIntegerMappingOption_t {
    QByteArrayData data[5];
    char stringdata0[80];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__ProgramIntegerMappingOption_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__ProgramIntegerMappingOption_t qt_meta_stringdata_BSH__ProgramIntegerMappingOption = {
    {
QT_MOC_LITERAL(0, 0, 32), // "BSH::ProgramIntegerMappingOption"
QT_MOC_LITERAL(1, 33, 20), // "mappedOptionsChanged"
QT_MOC_LITERAL(2, 54, 0), // ""
QT_MOC_LITERAL(3, 55, 13), // "mappedOptions"
QT_MOC_LITERAL(4, 69, 10) // "QList<int>"

    },
    "BSH::ProgramIntegerMappingOption\0"
    "mappedOptionsChanged\0\0mappedOptions\0"
    "QList<int>"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__ProgramIntegerMappingOption[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       1,   20, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   19,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // properties: name, type, flags
       3, 0x80000000 | 4, 0x0049500b,

 // properties: notify_signal_id
       0,

       0        // eod
};

void BSH::ProgramIntegerMappingOption::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ProgramIntegerMappingOption *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->mappedOptionsChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ProgramIntegerMappingOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramIntegerMappingOption::mappedOptionsChanged)) {
                *result = 0;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 0:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ProgramIntegerMappingOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QList<int>*>(_v) = _t->m_mapped_options; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<ProgramIntegerMappingOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_mapped_options != *reinterpret_cast< QList<int>*>(_v)) {
                _t->m_mapped_options = *reinterpret_cast< QList<int>*>(_v);
                Q_EMIT _t->mappedOptionsChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject BSH::ProgramIntegerMappingOption::staticMetaObject = { {
    &ProgramIntegerOption::staticMetaObject,
    qt_meta_stringdata_BSH__ProgramIntegerMappingOption.data,
    qt_meta_data_BSH__ProgramIntegerMappingOption,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::ProgramIntegerMappingOption::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::ProgramIntegerMappingOption::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__ProgramIntegerMappingOption.stringdata0))
        return static_cast<void*>(this);
    return ProgramIntegerOption::qt_metacast(_clname);
}

int BSH::ProgramIntegerMappingOption::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = ProgramIntegerOption::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 1)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 1;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void BSH::ProgramIntegerMappingOption::mappedOptionsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
struct qt_meta_stringdata_BSH__ProgramStringOption_t {
    QByteArrayData data[7];
    char stringdata0[97];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__ProgramStringOption_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__ProgramStringOption_t qt_meta_stringdata_BSH__ProgramStringOption = {
    {
QT_MOC_LITERAL(0, 0, 24), // "BSH::ProgramStringOption"
QT_MOC_LITERAL(1, 25, 19), // "currentIndexChanged"
QT_MOC_LITERAL(2, 45, 0), // ""
QT_MOC_LITERAL(3, 46, 14), // "optionsChanged"
QT_MOC_LITERAL(4, 61, 12), // "currentIndex"
QT_MOC_LITERAL(5, 74, 7), // "options"
QT_MOC_LITERAL(6, 82, 14) // "QList<QString>"

    },
    "BSH::ProgramStringOption\0currentIndexChanged\0"
    "\0optionsChanged\0currentIndex\0options\0"
    "QList<QString>"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__ProgramStringOption[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       2,   26, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   24,    2, 0x06 /* Public */,
       3,    0,   25,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       4, QMetaType::Int, 0x00495003,
       5, 0x80000000 | 6, 0x0049500b,

 // properties: notify_signal_id
       0,
       1,

       0        // eod
};

void BSH::ProgramStringOption::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ProgramStringOption *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->currentIndexChanged(); break;
        case 1: _t->optionsChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ProgramStringOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramStringOption::currentIndexChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ProgramStringOption::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ProgramStringOption::optionsChanged)) {
                *result = 1;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<QString> >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ProgramStringOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->m_currentIndex; break;
        case 1: *reinterpret_cast< QList<QString>*>(_v) = _t->m_options; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<ProgramStringOption *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_currentIndex != *reinterpret_cast< int*>(_v)) {
                _t->m_currentIndex = *reinterpret_cast< int*>(_v);
                Q_EMIT _t->currentIndexChanged();
            }
            break;
        case 1:
            if (_t->m_options != *reinterpret_cast< QList<QString>*>(_v)) {
                _t->m_options = *reinterpret_cast< QList<QString>*>(_v);
                Q_EMIT _t->optionsChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject BSH::ProgramStringOption::staticMetaObject = { {
    &ProgramOption::staticMetaObject,
    qt_meta_stringdata_BSH__ProgramStringOption.data,
    qt_meta_data_BSH__ProgramStringOption,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::ProgramStringOption::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::ProgramStringOption::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__ProgramStringOption.stringdata0))
        return static_cast<void*>(this);
    return ProgramOption::qt_metacast(_clname);
}

int BSH::ProgramStringOption::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = ProgramOption::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void BSH::ProgramStringOption::currentIndexChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BSH::ProgramStringOption::optionsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
struct qt_meta_stringdata_BSH__ProgramBooleanOption_t {
    QByteArrayData data[3];
    char stringdata0[33];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__ProgramBooleanOption_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__ProgramBooleanOption_t qt_meta_stringdata_BSH__ProgramBooleanOption = {
    {
QT_MOC_LITERAL(0, 0, 25), // "BSH::ProgramBooleanOption"
QT_MOC_LITERAL(1, 26, 5), // "value"
QT_MOC_LITERAL(2, 32, 0) // ""

    },
    "BSH::ProgramBooleanOption\0value\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__ProgramBooleanOption[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,   19,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Bool,

       0        // eod
};

void BSH::ProgramBooleanOption::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ProgramBooleanOption *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { bool _r = _t->value();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject BSH::ProgramBooleanOption::staticMetaObject = { {
    &ProgramOption::staticMetaObject,
    qt_meta_stringdata_BSH__ProgramBooleanOption.data,
    qt_meta_data_BSH__ProgramBooleanOption,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::ProgramBooleanOption::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::ProgramBooleanOption::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__ProgramBooleanOption.stringdata0))
        return static_cast<void*>(this);
    return ProgramOption::qt_metacast(_clname);
}

int BSH::ProgramBooleanOption::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = ProgramOption::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 1)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 1;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
