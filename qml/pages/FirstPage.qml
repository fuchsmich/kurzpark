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
    property string time:  cityLM.currentTime.time
    property string phoneNumber: cityLM.currentCity.phoneNumbers.get(0).number
    property string costs: timeLoader.item.costs

    property string plateNumber: platesLM.currentPlate

    property string smsText: time + zone + " " + city + "*" + plateNumber

    onSmsTextChanged: app.smsText = smsText
    onPhoneNumberChanged: app.phoneNumber = phoneNumber

    function outputList(list) {
        for (var i=0; i < list.count; i++) {
            console.log(list.get(i))
        }
    }

    function timeFormat(minutes) {
        var hh = Math.floor(minutes/60)
        var mm = minutes%60

        hh = hh < 10 ? "0"+ hh : hh
        mm = mm < 10 ? "0" + mm : mm

        return "(" + hh + ":" + mm + ")"
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
                width: parent.width
                //                x: Theme.paddingLarge
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
                }
            }

            ComboBox {
                id: citySelector
                width: page.width/2
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

            Row {
                spacing: Theme.paddingLarge
                //                x: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    width: page.width/3
                    text: qsTr("Karte")
                    onClicked: pageStack.push(Qt.resolvedUrl("MapPage.qml"))
                }

                Button {
                    //                    anchors.right: parent.right
                    width: page.width/3
                    //                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Info")
                    onClicked: {
                        var url = "http://www.handyparken.at/handyparken/content/staedte/" + cityLM.currentCity.infoURL
                        console.log(url)
                        Qt.openUrlExternally(url)
                    }
                }
            }
            //            Row {
            //                x: Theme.paddingLarge
            ComboBox {
                id: zoneSelector
                width: page.width //2
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

            Loader {
                id: timeLoader
                width: page.width

//                onLoaded: timeBinder.target = timeLoader.item
            }

            Binding {
                id: timeBinder
                property: "value"
                value: page.time
                when: page.state == "floating"
            }

            Component {
                id: timeCBComponent
                ComboBox {
                    property string costs: cityLM.currentTime.costs.toLocaleString(Qt.locale(),'f',2) + " €"
                    label: qsTr("Zeit")+":"
                    currentIndex: cityLM.currentTimeIndex
                    description: timeFormat(value)
                    menu: ContextMenu {
                        Repeater {
                            id: timeRep
                            model: cityLM.currentZone.timeList
                            MenuItem { text: model.text ? model.text : model.time }// + " " + timeFormat(model.time) }
                        }
                    }
                    onCurrentIndexChanged: {
                        cityLM.currentTimeIndex = currentIndex
                    }
                }
            }

            Component {
                id: timeStartStopComponent
                Row {
                    x: Theme.paddingLarge
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    property bool start: cityLM.currentTimeIndex
                    property string value: !cityLM.currentTimeIndex ? "Start" : "Stop"
                    property string costs: cityLM.currentZone.timeList.get(1).costs + "€/"
                                           + cityLM.currentZone.timeList.get(1).time +" min."
                    Button {
//                        width: page.width/4
                        text: "Start";
                        enabled: cityLM.currentTimeIndex;
                        onClicked: cityLM.currentTimeIndex = !cityLM.currentTimeIndex
                    }
                    Button {
//                        width: page.width/4
                        text: "Stop"
                        enabled: !cityLM.currentTimeIndex;
                        onClicked: cityLM.currentTimeIndex = !cityLM.currentTimeIndex
                    }
                }
            }

            Component {
                id: timeSliderComponent
                Slider {
//                    id: timeSlider
                    property string costs: ((value-minimumValue)*cityLM.currentZone.timeList.get(2).costs
                                           + cityLM.currentZone.timeList.get(0).costs).toLocaleString(Qt.locale(),'f',2) + " €"
                    minimumValue: cityLM.currentZone.timeList.get(0).time
                    maximumValue: cityLM.currentZone.timeList.get(1).time
                    stepSize: cityLM.currentZone.timeList.get(2).time
                    value: cityLM.currentTime.time //cityLM.currentZone.timeList.get(0).time
                    valueText: value + " " + timeFormat(value)
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
                text: qsTr("Kosten") +": " + costs
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    state: cityLM.currentCity.timeModel

    states: [
        State {
            name: "discrete"
            PropertyChanges { target: timeLoader; sourceComponent: timeCBComponent }
            PropertyChanges { target: page; time: timeLoader.item.value }
//            PropertyChanges { target: page; costs: timeLoader.item.costs.toLocaleString(Qt.locale(),'f',2) + " €"}
        },
        State {
            name: "floating"
            PropertyChanges { target: timeLoader; sourceComponent: timeSliderComponent }
            PropertyChanges { target: page; time: timeLoader.item.value }
//            PropertyChanges { target: page; costs: timeLoader.item.costs.toLocaleString(Qt.locale(),'f',2) + " €"}
        },
        State {
            name: "startstop"
            PropertyChanges { target: timeLoader; sourceComponent: timeStartStopComponent }
            PropertyChanges { target: page; time: timeLoader.item.value }
//            PropertyChanges { target: page; costs: timeLoader.item.costs.toLocaleString(Qt.locale(),'f',2) + " €"}
        }
    ]
}


