#ifndef PROGRAM_DEFINITION_H
#define PROGRAM_DEFINITION_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QMetaProperty>

namespace BSH
{

class ProgramDefinition : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool isFavorite MEMBER m_isFavorite WRITE setIsFavorite NOTIFY isFavoriteChanged)
    Q_PROPERTY(QString name MEMBER m_name NOTIFY nameChanged)
    Q_PROPERTY(QString tileImage MEMBER m_tileImage NOTIFY tileImageChanged)
    Q_PROPERTY(QString tileIcon MEMBER m_tileIcon NOTIFY tileIconChanged)
    Q_PROPERTY(QString favoriteTileImage MEMBER m_favoriteTileImage NOTIFY favoriteTileImageChanged)
    Q_PROPERTY(QString bgImage MEMBER m_bgImage NOTIFY bgImageChanged)
    Q_PROPERTY(QString runningImage MEMBER m_runningImage NOTIFY runningImageChanged)
    Q_PROPERTY(QString runningVideo MEMBER m_runningVideo NOTIFY runningVideoChanged)
    Q_PROPERTY(ProgramDefinition* origin MEMBER m_origin NOTIFY originChanged)

    // TODO This is a quickhack due and should be replaced with true theme support
    Q_PROPERTY(bool useDarkTheme MEMBER m_useDarkTheme NOTIFY useDarkThemeChanged)

public:
    explicit ProgramDefinition(QObject *parent = nullptr) :
        QObject(parent)
    {}

    void setIsFavorite(bool isFavorite)
    {
        if (!m_isFavorite && isFavorite) {
            m_origin = this;
            emit originChanged();
        }
        m_isFavorite = isFavorite;
        emit isFavoriteChanged();
    }

    // This function can not fetch pointer contents, add those manually if needed
    Q_INVOKABLE virtual void fetchBaseDefinition(ProgramDefinition* definition)
    {
        for (int i = 1; i < metaObject()->propertyOffset(); ++i) {
            auto&& property = metaObject()->property(i);
            property.write(this, property.read(definition));
        }
    }

signals:
    void isFavoriteChanged();
    void nameChanged();
    void tileImageChanged();
    void tileIconChanged();
    void favoriteTileImageChanged();
    void bgImageChanged();
    void runningImageChanged();
    void runningVideoChanged();
    void originChanged();
    void useDarkThemeChanged();

protected:
    template<typename T>
    void fetchPointerData(const char* propertyName, T* source)
    {
        T* target {property(propertyName).value<T*>()};

        if (source) {
            if(!target) target = new T(this);
            *target = *source;
        } else {
            target = nullptr;
        }

        setProperty(propertyName, qVariantFromValue(target));
    }

private:
    bool m_isFavorite {false};
    QString m_name {};
    QString m_tileImage {};
    QString m_tileIcon {};
    QString m_favoriteTileImage {};
    QString m_bgImage {};
    QString m_runningImage {};
    QString m_runningVideo {};
    ProgramDefinition* m_origin {this};
    bool m_useDarkTheme {true};
};

}

#endif // PROGRAM_DEFINITION_H
