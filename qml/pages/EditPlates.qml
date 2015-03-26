/*
  Copyright (C) 2015 Michael Fuchs <michfu@gmx.at>
  All rights reserved.

*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property var editPlatesModel

    id: page
    SilicaListView {
        model: plateList
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Kennzeichen")
        }
        delegate: ListItem {
            id: delegate
            function remove() {
                remorseAction("Entfernen", function() { plateList.remove(index) })
            }
            ListView.onRemove: animateRemoval()
            Row {
                x: Theme.paddingLarge
                Label {
                    //                id: tfPlate
                    text: number
                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    //                readOnly: true
                    //                validator: RegExpValidator {regExp: /^([0-9]|[A-Z])+$/ }
                    //                onAccepted: { readOnly = true }
                    //                onAcceptableInputChanged: { readOnly = true }
                }
                Label {
                    text: "    (" + comment + ")"
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    font.italic: true
                }
            }
            menu: Component {
                ContextMenu {
                    MenuItem {
                        text: "Bearbeiten"
                        onClicked: {
                            //                            tfPlate.readOnly = false
                            //                            tfPlate.focus = true
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





