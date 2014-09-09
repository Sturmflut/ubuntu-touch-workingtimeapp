import QtQuick 2.0
import Ubuntu.Components 1.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.sturmflut.workingtimeapp"

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
        title: i18n.tr("Working time calculator")

        Column {
            anchors.fill: parent

            Label {
                id: operationLabel
                text: i18n.tr("Calculate for:")
            }

            OptionSelector {
                ListModel {
                    id: operationModel

                    ListElement { name: "End time"   }
                    ListElement { name: "Working time"     }
                    ListElement { name: "Start time" }
                }

                id: operationSelector
                model: operationModel
            }

            Grid {
                spacing: units.gu(1)

                columns: 2

                Label {
                    text: i18n.tr("Start:")
                }

                Button {
                    id: startButton
                    property date date: "2000-01-01 08:00:00"
                    text: Qt.formatTime(date, "hh:mm")
                    onClicked: PickerPanel.openDatePicker(startButton, "date", "Hours:Minutes")
                }

                Label {
                    text: i18n.tr("Working:")
                }

                Button {
                    id: workingButton
                    property date date: "2000-01-01 10:00:00"
                    text: Qt.formatTime(date, "hh:mm")
                    onClicked: PickerPanel.openDatePicker(workingButton, "date", "Hours:Minutes")
                }

                Label {
                    text: i18n.tr("Rest:")
                }

                Button {
                    id: restButton
                    property date date: "2000-01-01 01:15:00"
                    text: Qt.formatTime(date, "hh:mm")
                    onClicked: PickerPanel.openDatePicker(restButton, "date", "Hours:Minutes")
                }

                Label {
                    text: i18n.tr("End:")
                }

                Button {
                    id: endButton
                    property date date: "2000-01-01 17:00:00"
                    text: Qt.formatTime(date, "hh:mm")
                    onClicked: PickerPanel.openDatePicker(endButton, "date", "Hours:Minutes")
                }
            }

            Button {
                text: i18n.tr("Calculate")

                onClicked: {
                    // Calculate  End time
                    if(operationSelector.selectedIndex == 0)
                    {
                        var result = new Date("2000-01-01 00:00:00")
                        result.setHours(startButton.date.getHours() + workingButton.date.getHours() + restButton.date.getHours())
                        result.setMinutes(startButton.date.getMinutes() + workingButton.date.getMinutes() + restButton.date.getMinutes())
                        endButton.date = result
                    }
                    // Calculate Working time
                    if(operationSelector.selectedIndex == 1)
                    {
                        var result = new Date("2000-01-01 00:00:00")
                        result.setHours(endButton.date.getHours() - restButton.date.getHours() - startButton.date.getHours())
                        result.setMinutes(endButton.date.getMinutes() - restButton.date.getMinutes() - startButton.date.getMinutes())
                        workingButton.date = result
                    }
                    // Calculate Start time
                    if(operationSelector.selectedIndex == 2)
                    {
                        var result = new Date("2000-01-01 00:00:00")
                        result.setHours(endButton.date.getHours() - restButton.date.getHours() - workingButtonButton.date.getHours())
                        result.setMinutes(endButton.date.getMinutes() - restButton.date.getMinutes() - workingButton.date.getMinutes())
                        startButton.date = result
                    }
                }
            }
        }
    }
}
