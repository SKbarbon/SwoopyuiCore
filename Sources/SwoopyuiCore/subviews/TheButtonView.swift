//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 27/08/2023.
//

import SwiftUI

struct TheButtonView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        Button (action: {
            pushClientUpdate(hostPort: "\(hostPort)", args: [
                "action" : "view_event",
                "view_id" : "\(subviewData.ID!)",
                "event_content" : [
                    "name" : "on_click"
                ]
            ])
        }) {
            VStack {
                ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                    ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
                }
            }
        }
    }
}


