/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "components"

ApplicationWindow
{
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    LocalDb {
        id: data
    }

    ListModel {
         id: plateList
//         ListElement { number: "MD287IM"; desc:"Meins" }
     }

     ListModel {
         id: cityList
         ListElement {
             name: "Wien";
             phoneNumbers: [
                 ListElement{number: "+436646600990"},
                 ListElement{number: "+436646606000"}
             ]
             text: "Wien";
             timeList: [
                 ListElement{time: 15; costs: 0},
                 ListElement{time: 30; costs: 1},
                 ListElement{time: 60; costs: 2},
                 ListElement{time: 90; costs: 3},
                 ListElement{time: 120; costs: 4},
                 ListElement{time: 180; costs: 6}
             ]
         }
         ListElement {
             name: "Mödling";
             phoneNumbers:[
                 ListElement{number: "+436646606000"}
             ]
             text: "Moedling";
             timeList: [
                 ListElement{time: 30; costs: 0.5},
                 ListElement{time: 60; costs: 1},
                 ListElement{time: 90; costs: 1.5},
                 ListElement{time: 120; costs: 2},
                 ListElement{time: 150; costs: 2.5},
                 ListElement{time: 180; costs: 3.0}
             ]
         }
         ListElement {
             name: "Perchtoldsdorf";
             phoneNumbers:[
                 ListElement{number: "+436646606000"}
             ]
             text: "Perchtoldsdorf";
             timeList: [
                 ListElement{time: 15; costs: 0},
                 ListElement{time: 30; costs: 0.5},
                 ListElement{time: 60; costs: 1},
                 ListElement{time: 90; costs: 1.5},
                 ListElement{time: 120; costs: 2},
                 ListElement{time: 150; costs: 2.5},
                 ListElement{time: 180; costs: 3.0}
             ]
         }
 //        ListElement { name: "Amstetten"; time: "1"  }
 //        ListElement { name: "Bregenz"; time: "1"   }
 //        ListElement { name: "Eisenstadt"; time: "1"   }
 //        ListElement { name: "Gleisdorf"; time: "1"   }
 //        ListElement { name: "Graz"; time: "1"   }
 //        ListElement { name: "Klagenfurt"; time: "1"   }
 //        ListElement { name: "Korneuburg"; time: "1"   }
 //        ListElement { name: "Linz"; time: "1" }
 //        ListElement { name: "Mödling"; time: "1" }
 //        ListElement { name: "Neusiedl am See"; time: "1" }
 //        ListElement { name: "Perchtoldsdorf"; time: "1" }
 //        ListElement { name: "Salzburg"; time: "1" }
 //        ListElement { name: "Schwechat"; time: "1" }
 //        ListElement { name: "Spittal a. d. Drau"; time: "1" }
 //        ListElement { name: "St. Pölten"; time: "1" }
 //        ListElement { name: "Stockerau"; time: "1" }
 //        ListElement { name: "Villach"; time: "1" }
 //        ListElement { name: "Villach"; time: "1" }
 //        ListElement { name: "Weiz"; time: "1" }
 //        ListElement { name: "Wels"; time: "1" }
 //        ListElement { name: "Wolfsberg"; time: "1" }
     }


     Component.onCompleted: data.loadSettings(plateList)
     Component.onDestruction: data.saveSettings(plateList)
}


