/*
  Copyright (C) 2015 Michael Fuchs <michfu@gmx.at>
  All rights reserved.

*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"


Page {
    id: page
    property var timeList: cityLM.get(cityLM.currentIndex).timeList
    property string city: cityLM.get(cityLM.currentIndex).text
    property string time: timeList.get(cityLM.currentTimeIndex).time
    property string plateNumber: platesLM.get(platesLM.currentIndex).number
    property string phoneNumber: cityLM.get(cityLM.currentIndex).phoneNumbers.get(0).number
    property real costs: timeList.get(cityLM.currentTimeIndex).costs

    property string smsText: time + " " + city + "*" + plateNumber

    onSmsTextChanged: app.smsText = smsText
    onPhoneNumberChanged: app.phoneNumber = phoneNumber


    Settings {
        id: settings
    }


    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
//            MenuItem {
//                text: qsTr("Städte bearbeiten")
//                onClicked: pageStack.push(Qt.resolvedUrl("EditCities.qml"))
//            }
            MenuItem {
                text: qsTr("Kennzeichen bearbeiten")
                onClicked: pageStack.push(Qt.resolvedUrl("PlatesList.qml"))
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
                currentIndex: cityLM.currentIndex
                menu: ContextMenu {
                      Repeater {
                           model: cityLM
                           MenuItem { text: model.name }
                      }
                 }
                onCurrentIndexChanged: {
                    cityLM.currentIndex = currentIndex
                    cityLM.currentTimeIndex = 0
                    city = cityLM.get(currentIndex).text
                    timeList = cityLM.get(currentIndex).timeList
                }
            }

            ComboBox {
                width: page.width
                label: qsTr("Autonummer:")
                currentIndex: platesLM.currentIndex
                menu: ContextMenu {
                    Repeater {
                         id:plateRep
                         model: platesLM
                         MenuItem { text: model.number + " <i>(" + model.desc +")</i>"}
                    }
                }
                onCurrentIndexChanged: {
                    plateNumber = platesLM.get(currentIndex).number
                    platesLM.currentIndex = currentIndex
                    platesLM.save()
                }
            }

            ComboBox {
                id: timeSelector
                width: page.width
                label: qsTr("Zeit:")
                currentIndex: cityLM.currentTimeIndex
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
//                text: qsTr("SMS senden")
                text: smsText
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
//                    smsIf.typedCall("startSMS", [ { 'type':'as', 'value': [phoneNumber] }, { 'type':'s', 'value': smsText.text } ])
                    Qt.openUrlExternally("sms:" + phoneNumber + "?body=" + smsText)
                    console.log("sms:" + phoneNumber + "?body=" + smsText)
                }

            }
//            Label {
//                id: smsTextLbl
//                text: smsText
////                text: timeRep.itemAt(timeSelector.currentIndex)
//                anchors.horizontalCenter: parent.horizontalCenter
//            }
            Label {
//                id: c
                text: qsTr("Kosten: ") + costs.toLocaleString(Qt.locale()) + " €"
//                text: timeRep.itemAt(timeSelector.currentIndex)
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}


