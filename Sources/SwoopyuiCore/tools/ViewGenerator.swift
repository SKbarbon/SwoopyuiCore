//
//
//  
//
//
//

import SwiftUI

struct ViewGenerator: View {
    @State var subviewData : SubView
    @Binding var hostUpdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        VStack {
            if  subviewData.name == "Text" {
                TheTextView(subviewData: $subviewData)
            } else if subviewData.name == "VStack" {
                TheVstackView (subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "NavigationSplitView" {
                TheNavigationSplitView(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "Button" {
                TheButtonView(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "NavigationLink" {
                TheNavigationLink(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "TextField" {
                TheTextFieldView(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "ScrollView" {
                TheScrollView(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "HStack" {
                TheHstackView(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "ColorView" {
                TheColorView(subviewData:  $subviewData)
            } else if subviewData.name == "TheListView" {
                TheListView(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "Sheet" {
                TheSheetView(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "Spacer" {
                SpacerView(subviewData: $subviewData)
            } else if subviewData.name == "ElevatedButton" {
                ElevatedButton(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "TextButton" {
                TextButtonView(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            } else if subviewData.name == "TheLabelView" {
                TheLabelView(subviewData: $subviewData, subviewupdates: $hostUpdates)
            } else if subviewData.name == "Icon" {
                TheIconView(subviewData: $subviewData, subviewupdates: $hostUpdates)
            } else if subviewData.name == "ContextMenu" {
                TheContextMenu(subviewData: $subviewData, subviewupdates: $hostUpdates, hostPort: hostPort)
            }
            
            // Shapes views
            else if subviewData.name == "RoundedRectangleShape" {
                RoundedRectangleShapeView(subviewData: $subviewData)
            }
        }
        .onChange (of: hostUpdates){_ in
            if hostUpdates != [] {
                if hostUpdates[0].action == "add_subview" {
                    addNewSubview(updat:  hostUpdates[0])
                } else if hostUpdates[0].action == "update_subview" {
                    print("Host updates: \(hostUpdates[0])")
                    updateSubviewProps(updat: hostUpdates[0])
                } else {
                    print("Unknown update: \(hostUpdates[0])")
                    if hostUpdates[0].action == nil {
                        hostUpdates.remove(at: 0)
                    }
                }
            }
        }
    }
    func updateSubviewProps (updat:SubViewUpdateRequest) {
        if subviewData.sub_views != [] && subviewData.sub_views != nil {
            var newSubviewsList : [SubView] = []
            for sv in subviewData.sub_views! {
                if sv.ID == updat.subview_data?.ID {
                    newSubviewsList.append(updat.subview_data!)
                    hostUpdates.remove(at: 0)
                } else {
                    newSubviewsList.append(sv)
                }
            }
            subviewData.sub_views = newSubviewsList
        }
    }
    func addNewSubview (updat:SubViewUpdateRequest) {
        if Int(updat.to_id!)! == subviewData.ID {
            subviewData.sub_views?.append(updat.subview_data!)
            hostUpdates.remove(at: 0)
        }
    }
}
