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
//                    platesLM.save()
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
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.paddingLarge
                TextField {
                    width: page.width*0.4
                    id: plateTf
                    text: number
//                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    readOnly: true
                    validator: RegExpValidator {regExp: /^([0-9]|[A-Z])+$/ }
                    //                onAccepted: { readOnly = true }
                    //                onAcceptableInputChanged: { readOnly = true }
                }
                TextField {
                    width: page.width*0.4
                    id: descTf
                    text: desc
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
//                    anchors.verticalCenter: parent.verticalCenter
                    font.italic: true
                    readOnly: true
                }
                IconButton {
                    id: saveBtn
                    icon.source: "image://theme/icon-cover-next"
                    icon.width: Theme.iconSizeSmall
                    icon.height: Theme.iconSizeSmall
                    width: Theme.iconSizeSmall + Theme.paddingSmall
//                    text: "Save"
                    visible: false
                    onClicked: {
                        plateTf.readOnly = descTf.readOnly = true
                        visible = false
                        platesLM.set(index, {"number": plateTf.text, "desc": descTf.text})
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





