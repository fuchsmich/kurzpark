/*
  Copyright (C) 2015 Michael Fuchs
  Contact: Michael Fuchs <michfu@gmx.at>
  All rights reserved.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"


Page {
    id: page
//    property var timeList: cityLM.currentZone.timeList
    property string city: cityLM.currentCity.text
    property string zone: cityLM.currentZone.zone
    property string time: cityLM.currentTime.time
    property string phoneNumber: cityLM.currentCity.phoneNumbers.get(0).number
    property string costs: cityLM.currentTime.costs.toLocaleString(Qt.locale()) + " €"

    property string plateNumber: platesLM.currentPlate

    property string smsText: time + " " + city + "*" + plateNumber

    onSmsTextChanged: app.smsText = smsText
    onPhoneNumberChanged: app.phoneNumber = phoneNumber


    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Kennzeichen bearbeiten")
                onClicked: pageStack.push(Qt.resolvedUrl("PlatesList.qml"))
            }
        }

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("SMS für Parkticket erstellen")
            }

            ComboBox {
                width: parent.width
                x: Theme.paddingLarge
                label: qsTr("Kennzeichen")+":"
                currentIndex: platesLM.currentIndex
                menu: ContextMenu {
                    Repeater {
                        id:plateRep
                        model: platesLM
                        MenuItem { text: model.number + " <i>(" + model.desc +")</i>"}
                    }
                }
                onClicked: {
                    if (platesLM.count == 0) {
                        pageStack.push(Qt.resolvedUrl("PlatesList.qml"))
                    }
                }

                onCurrentIndexChanged: {
                    platesLM.currentIndex = currentIndex
//                    page.plChanged()
                }
            }


            ComboBox {
                id: citySelector
                width: parent.width
                x: Theme.paddingLarge
                label: qsTr("Ort")+":"
                currentIndex: cityLM.currentIndex
                menu: ContextMenu {
                    Repeater {
                        model: cityLM
                        MenuItem { text: model.name }
                    }
                }
                onCurrentIndexChanged: {
                    cityLM.currentTimeIndex = 0
                    cityLM.currentTimeZoneIndex = 0
                    cityLM.currentIndex = currentIndex
                }
            }

            Button {
//                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Info")
            }

            ComboBox {
//                id: zoneSelector
                width: parent.width
                x: Theme.paddingLarge
                label: qsTr("Zone")+":"
//                visible: (cityLM.currentCity.timeZoneList.count > 1)
                enabled: (cityLM.currentCity.timeZoneList.count > 1)
                currentIndex: cityLM.currentTimeZoneIndex
                menu: ContextMenu {
                    Repeater {
                        model: cityLM.currentCity.timeZoneList
                        MenuItem { text: model.zone }
                    }
                }
                onCurrentIndexChanged: {
                    cityLM.currentTimeIndex = 0
                    cityLM.currentTimeZoneIndex = currentIndex
                }
            }

            ComboBox {
                id: timeSelector
                width: parent.width
                x: Theme.paddingLarge
                label: qsTr("Zeit")+":"
                currentIndex: cityLM.currentTimeIndex
                menu: ContextMenu {
                    Repeater {
                        id: timeRep
                        model: cityLM.currentZone.timeList
                        MenuItem { text: model.time }
                    }
                }
                onCurrentIndexChanged: {
                    cityLM.currentTimeIndex = currentIndex
                    //                        time = timeList.get(currentIndex).time
                    //                        costs = timeList.get(currentIndex).costs
                }
            }



            Button {
                //                text: qsTr("SMS senden")
                text: smsText
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    Qt.openUrlExternally("sms:" + phoneNumber + "?body=" + smsText)
                    console.log("sms:" + phoneNumber + "?body=" + smsText)
                }

            }
            Label {
                text: qsTr("Kosten: ") + costs
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}


