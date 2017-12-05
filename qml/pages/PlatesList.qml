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
                    listView.addPlate()
                }
            }
        }

        id: listView
        property var plates: config.plates.value
        function removePlate(i) {
            plates.splice(i,1)
            config.plates.value = plates
            config.plates.sync()
        }
        function addPlate() {
            listView.plates.push({number: "ASDASD"+listView.plates.length, desc:"desc"})
            config.plates.value = plates
            config.plates.sync()
        }

        model: plates
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Kennzeichen")
        }
        delegate: ListItem {
            id: delegate
            function remove() {
                remorseAction("Entfernen", function() { listView.removePlate(index) }) //TODO
            }
            ListView.onRemove: animateRemoval()
            Row {
                x: Theme.paddingLarge
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: plateTf
                    width: page.width*0.4
                    anchors.verticalCenter: parent.verticalCenter
                    text: listView.plates[index].number
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
//                    readOnly: true
//                    validator: RegExpValidator {regExp: /^([0-9]|[A-Z])+$/ }
//                    inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
                }
                Label {
                    id: descTf
                    width: page.width*0.4
                    anchors.verticalCenter: parent.verticalCenter
                    text: listView.plates[index].desc
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    font.italic: true
//                    readOnly: true
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
                        listView.plates[index].number = plateTf.text
                        listView.plates[index].number = descTf.text
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





