import QtQuick 2.0
import Ubuntu.Components 1.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.sturmflut.kitworkingtimeapp"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)

    Page {
        title: i18n.tr("Simple")

        Grid {
            spacing: units.gu(1)

            columns: 2

            Label {
                text: i18n.tr("Calculate for:")
            }

            OptionSelector {
                ListModel {
                    id: operationModel

                    ListElement { name: "Start time"   }
                    ListElement { name: "End time"     }
                    ListElement { name: "Working time" }
                }

                id: operationSelector
                model: operationModel
            }

            Label {
                text: i18n.tr("Start:")
            }

            Button {
                id: startButton
                property date date: new Date()
                text: Qt.formatTime(date, "hh:mm")
                onClicked: PickerPanel.openDatePicker(startButton, "date", "Hours:Minutes")
            }
        }
    }
}
