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

    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("Einstellungen zurücksetzen")
                onClicked: data.clearDB()
            }
        }

        Column {
            width: parent.width
            PageHeader {
                title: qsTr("Settings")
            }

            TextSwitch {
                text: "Send SMS directly"
                description: "Will send SMS without confirmation in Messages-App."
            }
        }
    }
}





