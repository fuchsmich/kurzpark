/*
  Copyright (C) 2015 Michael Fuchs
  Contact: Michael Fuchs <michfu@gmx.at>
  All rights reserved.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0

import "pages"
import "components"

ApplicationWindow
{
    id: app
    property string configPath: "/apps/harbour-zutun"
    ConfigurationGroup {
        id: config
        path: configPath
        property ConfigurationValue plates: ConfigurationValue {
            key: "/apps/harbour-zutun/plates"
            defaultValue: [{number: "MD123AF", desc: "Meins"}, {number: "W12345X", desc: "Deins"}]
            onValueChanged: console.log(value)
        }
    }



//    property string testStr: "hallo"
    property string smsText
    property string phoneNumber
//    property string s
//    onSmsTextChanged: cP.smsText = smsText

    initialPage: Component { MapPage { } }
    cover: Qt.resolvedUrl("pages/CoverPage.qml")

//    cover: Component { CoverPage{ id: cP } }

    PlatesListModel {
        id: platesLM
    }

    CityListModel {
        id: cityLM
    }


}


