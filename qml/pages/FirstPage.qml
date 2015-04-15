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
    property var timeList: cityLM.get(cityLM.currentIndex).timeList
    property string city: cityLM.get(cityLM.currentIndex).text
    property string time: timeList.get(cityLM.currentTimeIndex).time
    property string phoneNumber: cityLM.get(cityLM.currentIndex).phoneNumbers.get(0).number
    property real costs: timeList.get(cityLM.currentTimeIndex).costs

    property string plateNumber // platesLM.get(platesLM.currentIndex).number

    property string smsText: time + " " + city + "*" + plateNumber

    onSmsTextChanged: app.smsText = smsText
    onPhoneNumberChanged: app.phoneNumber = phoneNumber

    signal plChanged()

    onPlChanged: {
        plateNumber = platesLM.get(platesLM.currentIndex).number
        platesLM.save()
    }


    Component.onCompleted: {
        platesLM.dataChanged.connect(plChanged)
        platesLM.countChanged.connect(plChanged)
    }


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
                id: citySelector
                width: parent.width
                label: qsTr("Ort")+":"
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
                    //                    city = cityLM.get(currentIndex).text
                    //                    timeList = cityLM.get(currentIndex).timeList
                    //                    timeContainer.state = cityLM.get(currentIndex).timeModel
                }
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
                    page.plChanged()
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
                        model: timeList
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
                text: qsTr("Kosten: ") + costs.toLocaleString(Qt.locale()) + " €"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}


