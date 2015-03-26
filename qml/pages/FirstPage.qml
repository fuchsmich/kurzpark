/*
  Copyright (C) 2015 Michael Fuchs <michfu@gmx.at>
  All rights reserved.

*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"


Page {
    id: page
    property string city: settings.cityList.get(0).text
    property var timeList: settings.cityList.get(0).timeList
    property string time: timeList.get(0).time
    property string plateNumber: platesData.plates.get(0).number
    property string phoneNumber: settings.cityList.get(0).phoneNumbers.get(0).number
    property real costs: timeList.get(0).costs

    PlatesData {
        id: platesData
    }

    Settings {
        id: settings
    }


    Component.onCompleted: platesData.load()
    Component.onDestruction: platesData.save()


    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Städte bearbeiten")
                onClicked: pageStack.push(Qt.resolvedUrl("EditCities.qml"))
            }
            MenuItem {
                text: qsTr("Kennzeichen bearbeiten")
                onClicked: pageStack.push(Qt.resolvedUrl("EditPlates.qml"))
            }
            MenuItem {
                text: qsTr("Einstellungen")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("SMS für Parkticket erstellen")
            }

            ComboBox {
                id: citySelector
                width: page.width
                label: qsTr("Ort:")
                menu: ContextMenu {
                      Repeater {
                           model: settings.cityList
                           MenuItem { text: model.name }
                      }
                 }
                onCurrentIndexChanged: {
                    city = settings.cityList.get(currentIndex).text
                    timeList = settings.cityList.get(currentIndex).timeList
                }
            }

            ComboBox {
                width: page.width
                label: qsTr("Autonummer:")
                menu: ContextMenu {
                    Repeater {
                         id:plateRep
                         model: platesData.plates
                         MenuItem { text: model.number }
                    }
                }
                onCurrentIndexChanged: {
                    plateNumber = plateRep.itemAt(currentIndex).text
                }
            }

            ComboBox {
                id: timeSelector
                width: page.width
                label: qsTr("Zeit:")
                menu: ContextMenu {
                      Repeater {
                          id: timeRep
                          model: timeList
                          MenuItem { text: model.time }
                      }
                 }
                onCurrentIndexChanged: {
                    time = timeList.get(currentIndex).time
                    costs = timeList.get(currentIndex).costs
                }
            }

            Button {
                text: "Send SMS"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
//                    smsIf.typedCall("startSMS", [ { 'type':'as', 'value': [phoneNumber] }, { 'type':'s', 'value': smsText.text } ])
                    Qt.openUrlExternally("sms:" + phoneNumber + "?body=" + smsText.text)
                    console.log("sms:" + phoneNumber + "?body=" + smsText.text)
                }

            }
            Label {
                id: smsText
                text: time + " " + city + "*" + plateNumber
//                text: timeRep.itemAt(timeSelector.currentIndex)
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
//                id: c
                text: "Kosten: " + costs.toLocaleString(Qt.locale()) // + "€"
//                text: timeRep.itemAt(timeSelector.currentIndex)
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}


