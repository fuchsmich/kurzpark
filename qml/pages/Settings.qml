/*
  Copyright (C) 2015 Michael Fuchs <michfu@gmx.at>
  All rights reserved.

*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent
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





