import QtQuick 2.12
import Qt.labs.folderlistmodel 2.12

Loader {
    id: root
    property string folder
    property var imageTypes: ["*.png"]
    readonly property string fileURL: folder

    Component {
        id: preloader
        Item {
            FolderListModel {
                id: fileModel
                nameFilters: root.imageTypes
                folder: fileURL
                showDirs: false
            }
            FolderListModel {
                id: folderModel
                folder: fileURL
               // showFiles: false
            }
            Repeater {
                model: fileModel
                delegate: FastImage {
                    visible: false
                    source: fileURL
                }
            }
            Repeater {
                model: folderModel
                delegate: preloader
            }
        }
    }

    sourceComponent: preloader
}
