//
//  SwiftUIView.swift
//  
//
// 
//

import SwiftUI

struct TheScrollingTabView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    
    @State var currentSelection = 0
    var body: some View {
        #if os(macOS)
        
        #else
        TabView (selection: $currentSelection) {
            ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
                    .tag(subv.ID)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onChange(of: subviewupdates) {_ in
            var num = 0
            for u in subviewupdates {
                if u.action == "tabview_selection" {
                    if u.parent_id == subviewData.ID {
                        print("Navigated!")
                        currentSelection = u.subview_id!
                        subviewupdates.remove(at: num)
                    }
                }
                num = num + 1
            }
        }
        #endif
    }
}
