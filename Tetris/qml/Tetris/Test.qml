// FramePage.qml
  import Qt 4.7
  import com.nokia.meego 1.1

  Page {
      id: root
      anchors.margins: 0

      Item {
          id: container
      }

      property Item containerObject;

      onVisibleChanged: {
          if (visible) {
              // create component
              console.log("Page content created.");
              var object = componentDynamic.createObject(container);
              containerObject = object;
          } else {
              // destroy component
              console.log("Page content destroyed.");
              containerObject.destroy();
          }
      }

      // Page content inside component, this is created dynamically when page is visible
      Component {
          id: componentDynamic
          Item {
              id: content
              Column {
                  id: contentColumn
                  anchors.fill: parent
                  anchors.margins: 32
                  spacing: 24

                  Label {
                      text: "Page content"
                  }

                  Button {
                      id: buttonPush
                      text: "Push page FramePage.qml"
                      onClicked: { openFile("FramePage.qml"); }
                  }

                  Button {
                      id: buttonPop
                      text: "Pop page"
                      onClicked: { pageStack.pop(); }
                  }
              }
          }
      }

      function openFile(file) {
          var component = Qt.createComponent(file)

          if (component.status == Component.Ready)
              pageStack.push(component);
          else
              console.log("Error loading component:", component.errorString());
      }
  }
