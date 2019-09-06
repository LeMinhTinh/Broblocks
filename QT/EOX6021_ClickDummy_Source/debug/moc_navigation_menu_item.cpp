/****************************************************************************
** Meta object code from reading C++ file 'navigation_menu_item.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../navigation_menu_item.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'navigation_menu_item.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_BSH__NaviagtionMenuItem_t {
    QByteArrayData data[19];
    char stringdata0[255];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__NaviagtionMenuItem_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__NaviagtionMenuItem_t qt_meta_stringdata_BSH__NaviagtionMenuItem = {
    {
QT_MOC_LITERAL(0, 0, 23), // "BSH::NaviagtionMenuItem"
QT_MOC_LITERAL(1, 24, 11), // "nameChanged"
QT_MOC_LITERAL(2, 36, 0), // ""
QT_MOC_LITERAL(3, 37, 16), // "tileImageChanged"
QT_MOC_LITERAL(4, 54, 16), // "firstIconChanged"
QT_MOC_LITERAL(5, 71, 17), // "secondIconChanged"
QT_MOC_LITERAL(6, 89, 14), // "bgImageChanged"
QT_MOC_LITERAL(7, 104, 13), // "targetChanged"
QT_MOC_LITERAL(8, 118, 18), // "targetModelChanged"
QT_MOC_LITERAL(9, 137, 21), // "referencedItemChanged"
QT_MOC_LITERAL(10, 159, 4), // "name"
QT_MOC_LITERAL(11, 164, 9), // "tileImage"
QT_MOC_LITERAL(12, 174, 9), // "firstIcon"
QT_MOC_LITERAL(13, 184, 10), // "secondIcon"
QT_MOC_LITERAL(14, 195, 7), // "bgImage"
QT_MOC_LITERAL(15, 203, 6), // "target"
QT_MOC_LITERAL(16, 210, 14), // "referencedItem"
QT_MOC_LITERAL(17, 225, 11), // "targetModel"
QT_MOC_LITERAL(18, 237, 17) // "GenericListModel*"

    },
    "BSH::NaviagtionMenuItem\0nameChanged\0"
    "\0tileImageChanged\0firstIconChanged\0"
    "secondIconChanged\0bgImageChanged\0"
    "targetChanged\0targetModelChanged\0"
    "referencedItemChanged\0name\0tileImage\0"
    "firstIcon\0secondIcon\0bgImage\0target\0"
    "referencedItem\0targetModel\0GenericListModel*"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__NaviagtionMenuItem[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       8,   62, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       8,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x06 /* Public */,
       3,    0,   55,    2, 0x06 /* Public */,
       4,    0,   56,    2, 0x06 /* Public */,
       5,    0,   57,    2, 0x06 /* Public */,
       6,    0,   58,    2, 0x06 /* Public */,
       7,    0,   59,    2, 0x06 /* Public */,
       8,    0,   60,    2, 0x06 /* Public */,
       9,    0,   61,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
      10, QMetaType::QString, 0x00495003,
      11, QMetaType::QString, 0x00495003,
      12, QMetaType::QString, 0x00495003,
      13, QMetaType::QString, 0x00495003,
      14, QMetaType::QString, 0x00495003,
      15, QMetaType::QString, 0x00495003,
      16, QMetaType::QObjectStar, 0x00495003,
      17, 0x80000000 | 18, 0x0049500b,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,
       5,
       7,
       6,

       0        // eod
};

void BSH::NaviagtionMenuItem::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<NaviagtionMenuItem *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->nameChanged(); break;
        case 1: _t->tileImageChanged(); break;
        case 2: _t->firstIconChanged(); break;
        case 3: _t->secondIconChanged(); break;
        case 4: _t->bgImageChanged(); break;
        case 5: _t->targetChanged(); break;
        case 6: _t->targetModelChanged(); break;
        case 7: _t->referencedItemChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (NaviagtionMenuItem::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&NaviagtionMenuItem::nameChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (NaviagtionMenuItem::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&NaviagtionMenuItem::tileImageChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (NaviagtionMenuItem::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&NaviagtionMenuItem::firstIconChanged)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (NaviagtionMenuItem::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&NaviagtionMenuItem::secondIconChanged)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (NaviagtionMenuItem::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&NaviagtionMenuItem::bgImageChanged)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (NaviagtionMenuItem::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&NaviagtionMenuItem::targetChanged)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (NaviagtionMenuItem::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&NaviagtionMenuItem::targetModelChanged)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (NaviagtionMenuItem::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&NaviagtionMenuItem::referencedItemChanged)) {
                *result = 7;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 7:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< GenericListModel* >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<NaviagtionMenuItem *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->m_name; break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->m_tileImage; break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->m_firstIcon; break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->m_secondIcon; break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->m_bgImage; break;
        case 5: *reinterpret_cast< QString*>(_v) = _t->m_target; break;
        case 6: *reinterpret_cast< QObject**>(_v) = _t->m_referencedItem; break;
        case 7: *reinterpret_cast< GenericListModel**>(_v) = _t->m_target_model; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<NaviagtionMenuItem *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_name != *reinterpret_cast< QString*>(_v)) {
                _t->m_name = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->nameChanged();
            }
            break;
        case 1:
            if (_t->m_tileImage != *reinterpret_cast< QString*>(_v)) {
                _t->m_tileImage = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->tileImageChanged();
            }
            break;
        case 2:
            if (_t->m_firstIcon != *reinterpret_cast< QString*>(_v)) {
                _t->m_firstIcon = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->firstIconChanged();
            }
            break;
        case 3:
            if (_t->m_secondIcon != *reinterpret_cast< QString*>(_v)) {
                _t->m_secondIcon = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->secondIconChanged();
            }
            break;
        case 4:
            if (_t->m_bgImage != *reinterpret_cast< QString*>(_v)) {
                _t->m_bgImage = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->bgImageChanged();
            }
            break;
        case 5:
            if (_t->m_target != *reinterpret_cast< QString*>(_v)) {
                _t->m_target = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->targetChanged();
            }
            break;
        case 6:
            if (_t->m_referencedItem != *reinterpret_cast< QObject**>(_v)) {
                _t->m_referencedItem = *reinterpret_cast< QObject**>(_v);
                Q_EMIT _t->referencedItemChanged();
            }
            break;
        case 7:
            if (_t->m_target_model != *reinterpret_cast< GenericListModel**>(_v)) {
                _t->m_target_model = *reinterpret_cast< GenericListModel**>(_v);
                Q_EMIT _t->targetModelChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject BSH::NaviagtionMenuItem::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_BSH__NaviagtionMenuItem.data,
    qt_meta_data_BSH__NaviagtionMenuItem,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::NaviagtionMenuItem::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::NaviagtionMenuItem::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__NaviagtionMenuItem.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int BSH::NaviagtionMenuItem::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 8;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void BSH::NaviagtionMenuItem::nameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BSH::NaviagtionMenuItem::tileImageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void BSH::NaviagtionMenuItem::firstIconChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void BSH::NaviagtionMenuItem::secondIconChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void BSH::NaviagtionMenuItem::bgImageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void BSH::NaviagtionMenuItem::targetChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void BSH::NaviagtionMenuItem::targetModelChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void BSH::NaviagtionMenuItem::referencedItemChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
