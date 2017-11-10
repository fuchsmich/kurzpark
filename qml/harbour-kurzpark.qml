/*
  Copyright (C) 2015 Michael Fuchs
  Contact: Michael Fuchs <michfu@gmx.at>
  All rights reserved.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "components"

ApplicationWindow
{
    id: app

//    property string testStr: "hallo"
    property string smsText
    property string phoneNumber
//    property string s
//    onSmsTextChanged: cP.smsText = smsText

    initialPage: Component { FirstPage { id: fP } }
    cover: Qt.resolvedUrl("pages/CoverPage.qml")

//    cover: Component { CoverPage{ id: cP } }

    PlatesListModel {
        id: platesLM
    }

    CityListModel {
        id: cityLM
    }


}


