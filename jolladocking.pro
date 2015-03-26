# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = jolladocking

CONFIG += sailfishapp

SOURCES += src/jolladocking.cpp

OTHER_FILES += qml/jolladocking.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/jolladocking.changes.in \
    rpm/jolladocking.spec \
    rpm/jolladocking.yaml \
    translations/*.ts \
    jolladocking.desktop \
    qml/pages/cutouts.qml \
    qml/pages/EditCities.qml \
    qml/pages/EditPlates.qml \
    qml/pages/PlateModel.qml \
    qml/pages/Settings.qml \
    qml/components/LocalDb.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/jolladocking-de.ts

