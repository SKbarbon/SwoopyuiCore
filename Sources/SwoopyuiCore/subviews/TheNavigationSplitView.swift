//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 27/08/2023.
//

import SwiftUI

struct TheNavigationSplitView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        NavigationSplitView {
            ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
            }
            .navigationTitle("\(subviewData.props?.title ?? "")")
        } detail: {
            ForEach (subviewData.sub_views2!, id: \.update_id) {subv in
                ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
            }
            .navigationTitle("\(subviewData.props?.detail_title ?? "")")
        }
    }
}