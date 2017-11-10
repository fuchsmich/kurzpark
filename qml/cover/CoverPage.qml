/*
  Copyright (C) 2015 Michael Fuchs
  Contact: Michael Fuchs <michfu@gmx.at>
  All rights reserved.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    //    property string smsText
    Column {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: Theme.paddingMedium
        }

        Label {
            text: qsTr("KurzPark")
            width: parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.horizontalCenter
            truncationMode: TruncationMode.Fade
        }
        Label {
            text: smsText
            width: parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.horizontalCenter
            truncationMode: TruncationMode.Fade
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: Qt.openUrlExternally("sms:" + phoneNumber + "?body=" + smsText)
        }

        //        CoverAction {
        //            iconSource: "image://theme/icon-cover-pause"
        //        }
    }
}


