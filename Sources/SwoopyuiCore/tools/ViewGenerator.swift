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
    var body: some View {
        VStack {
            if  subviewData.name == "Text" {
                TheTextView(subviewData: $subviewData)
            } else if subviewData.name == "VStack" {
                TheVstackView (subviewData: $subviewData, subviewupdates: $hostUpdates)
            }
            
            else {
                Text("SwoopyUI have no view named \(subviewData.name!)")
                    .foregroundStyle(.red)
            }
        }
        .onChange (of: hostUpdates){_ in
            if hostUpdates != [] {
                if hostUpdates[0].action == "add_subview" {
                    addNewSubview(updat:  hostUpdates[0])
                    hostUpdates.remove(at: 0)
                } else if hostUpdates[0].action == "update_subview" {
                    updateSubviewProps(updat: hostUpdates[0])
                    hostUpdates.remove(at: 0)
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
        }
    }
}