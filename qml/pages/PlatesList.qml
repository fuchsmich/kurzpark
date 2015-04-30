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


    SilicaListView {
        PullDownMenu {
            MenuItem {
                text: qsTr("Kennzeichen hinzufügen")
                onClicked: {
                    platesLM.append({"number": "ASDASD"+platesLM.count, "desc":"desc"})
                }
            }
        }

        id: listView
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
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    readOnly: true
                    validator: RegExpValidator {regExp: /^([0-9]|[A-Z])+$/ }
                    inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
                }
                TextField {
                    width: page.width*0.4
                    id: descTf
                    text: desc
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    font.italic: true
                    readOnly: true
                }
                IconButton {
                    id: saveBtn
                    icon.source: "image://theme/icon-cover-next"
                    icon.width: Theme.iconSizeSmall
                    icon.height: Theme.iconSizeSmall
//                    width: Theme.iconSizeSmall + Theme.paddingSmall
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
                        text: qsTr("Bearbeiten")
                        onClicked: {
                            plateTf.readOnly = descTf.readOnly = false
                            saveBtn.visible = true
                        }
                    }
                    MenuItem {
                        text: qsTr("Entfernen")
                        onClicked: remove();
                    }
                }
            }
        }
    }
}





