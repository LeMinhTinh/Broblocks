/****************************************************************************
** Meta object code from reading C++ file 'generic_list_model.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../generic_list_model.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'generic_list_model.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_BSH__GenericListModel_t {
    QByteArrayData data[20];
    char stringdata0[166];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BSH__GenericListModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BSH__GenericListModel_t qt_meta_stringdata_BSH__GenericListModel = {
    {
QT_MOC_LITERAL(0, 0, 21), // "BSH::GenericListModel"
QT_MOC_LITERAL(1, 22, 15), // "DefaultProperty"
QT_MOC_LITERAL(2, 38, 7), // "content"
QT_MOC_LITERAL(3, 46, 11), // "sizeChanged"
QT_MOC_LITERAL(4, 58, 0), // ""
QT_MOC_LITERAL(5, 59, 14), // "contentChanged"
QT_MOC_LITERAL(6, 74, 6), // "append"
QT_MOC_LITERAL(7, 81, 1), // "o"
QT_MOC_LITERAL(8, 83, 6), // "insert"
QT_MOC_LITERAL(9, 90, 1), // "i"
QT_MOC_LITERAL(10, 92, 4), // "take"
QT_MOC_LITERAL(11, 97, 6), // "remove"
QT_MOC_LITERAL(12, 104, 6), // "object"
QT_MOC_LITERAL(13, 111, 3), // "get"
QT_MOC_LITERAL(14, 115, 4), // "move"
QT_MOC_LITERAL(15, 120, 4), // "from"
QT_MOC_LITERAL(16, 125, 2), // "to"
QT_MOC_LITERAL(17, 128, 4), // "size"
QT_MOC_LITERAL(18, 133, 25), // "QQmlListProperty<QObject>"
QT_MOC_LITERAL(19, 159, 6) // "parent"

    },
    "BSH::GenericListModel\0DefaultProperty\0"
    "content\0sizeChanged\0\0contentChanged\0"
    "append\0o\0insert\0i\0take\0remove\0object\0"
    "get\0move\0from\0to\0size\0QQmlListProperty<QObject>\0"
    "parent"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BSH__GenericListModel[] = {

 // content:
       8,       // revision
       0,       // classname
       1,   14, // classinfo
       9,   16, // methods
       3,   88, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // classinfo: key, value
       1,    2,

 // signals: name, argc, parameters, tag, flags
       3,    0,   61,    4, 0x06 /* Public */,
       5,    0,   62,    4, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       6,    1,   63,    4, 0x0a /* Public */,
       8,    2,   66,    4, 0x0a /* Public */,
      10,    1,   71,    4, 0x0a /* Public */,
      11,    1,   74,    4, 0x0a /* Public */,
      11,    1,   77,    4, 0x0a /* Public */,
      13,    1,   80,    4, 0x0a /* Public */,
      14,    2,   83,    4, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QObjectStar,    7,
    QMetaType::Void, QMetaType::QObjectStar, QMetaType::Int,    7,    9,
    QMetaType::QObjectStar, QMetaType::Int,    9,
    QMetaType::Void, QMetaType::Int,    9,
    QMetaType::Void, QMetaType::QObjectStar,   12,
    QMetaType::QObjectStar, QMetaType::Int,    9,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   15,   16,

 // properties: name, type, flags
      17, QMetaType::Int, 0x00495001,
       2, 0x80000000 | 18, 0x00495009,
      19, QMetaType::QObjectStar, 0x00095103,

 // properties: notify_signal_id
       0,
       1,
       0,

       0        // eod
};

void BSH::GenericListModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<GenericListModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->sizeChanged(); break;
        case 1: _t->contentChanged(); break;
        case 2: _t->append((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        case 3: _t->insert((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 4: { QObject* _r = _t->take((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 5: _t->remove((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: _t->remove((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        case 7: { QObject* _r = _t->get((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        case 8: _t->move((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (GenericListModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&GenericListModel::sizeChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (GenericListModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&GenericListModel::contentChanged)) {
                *result = 1;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<GenericListModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->size(); break;
        case 1: *reinterpret_cast< QQmlListProperty<QObject>*>(_v) = _t->content(); break;
        case 2: *reinterpret_cast< QObject**>(_v) = _t->parent(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<GenericListModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 2: _t->setParent(*reinterpret_cast< QObject**>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject BSH::GenericListModel::staticMetaObject = { {
    &QAbstractListModel::staticMetaObject,
    qt_meta_stringdata_BSH__GenericListModel.data,
    qt_meta_data_BSH__GenericListModel,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *BSH::GenericListModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BSH::GenericListModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BSH__GenericListModel.stringdata0))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int BSH::GenericListModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 9)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 9;
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
void BSH::GenericListModel::sizeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BSH::GenericListModel::contentChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
