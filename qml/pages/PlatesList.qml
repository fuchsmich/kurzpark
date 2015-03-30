/*
  Copyright (C) 2015 Michael Fuchs <michfu@gmx.at>
  All rights reserved.

*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {

    id: page

//    PlatesData {
//        id: platesData
//    }

    SilicaListView {
        id: listView
        PullDownMenu {
            MenuItem {
                text: qsTr("Kennzeichen hinzufügen")
                onClicked: {
                    platesLM.append({"number": "ASDASD"+platesLM.count, "desc":"deins"})
                    platesLM.save()
                }

            }
        }
        model: platesLM
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Kennzeichen")
        }
        delegate: ListItem {
            id: delegate
            function remove() {
                remorseAction("Entfernen", function() { platesLM.remove(index) })
            }
            ListView.onRemove: animateRemoval()
            Row {
                x: Theme.paddingLarge
                TextField {
                    id: plateTf
                    text: number
                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    readOnly: true
                    //                validator: RegExpValidator {regExp: /^([0-9]|[A-Z])+$/ }
                    //                onAccepted: { readOnly = true }
                    //                onAcceptableInputChanged: { readOnly = true }
                }
                TextField {
                    id: descTf
                    text: desc
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    font.italic: true
                    readOnly: true
                }
                Button {
                    id: saveBtn
                    text: "Save"
                    visible: false
                    onClicked: {
                        plateTf.readOnly = descTf.readOnly = true
                        visible = false
//                        platesLM.
                    }
                }
            }
            menu: Component {
                ContextMenu {
                    MenuItem {
                        text: "Bearbeiten"
                        onClicked: {
                            plateTf.readOnly = descTf.readOnly = false
                            saveBtn.visible = true
//                            pageStack.push()}
                                                    //, {plateIndex: listView.currentIndex}) }
                        }
                    }
                    MenuItem {
                        text: "Entfernen"
                        onClicked: remove();
                    }
                    MenuItem {
                        text: "Als Standard setzen"
                    }
                }
            }
        }
    }
}





