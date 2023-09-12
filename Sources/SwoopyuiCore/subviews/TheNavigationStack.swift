//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 12/09/2023.
//

import SwiftUI

struct TheNavigationStack: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        NavigationStack {
            VStack {
                ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                    ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
                }
            }
            .navigationTitle(subviewData.props?.title ?? "")
            .toolbar {
                ForEach (subviewData.sub_views2!, id: \.update_id) {subv in
                    ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
                }
            }
        }
    }
}
