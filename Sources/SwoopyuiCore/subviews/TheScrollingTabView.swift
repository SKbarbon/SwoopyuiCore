//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 29/08/2023.
//

import SwiftUI

struct TheScrollingTabView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        #if os(macOS)
        
        #else
        TabView {
            ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
        #endif
    }
}
