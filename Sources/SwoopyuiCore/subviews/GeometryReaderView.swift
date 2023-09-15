//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 15/09/2023.
//

import SwiftUI

struct GeometryReaderView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        GeometryReader {reader in
            VStack {
                ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                    ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
                }
            }
            .onAppear() {
                pushClientUpdate(hostPort: "\(hostPort)", args: [
                    "action" : "view_event",
                    "view_id" : "\(subviewData.ID!)",
                    "event_content" : [
                        "name" : "on_resize",
                        "width" : reader.size.width,
                        "height" : reader.size.height
                    ]
                ])
            }
            .onChange(of: reader.size){_ in
                pushClientUpdate(hostPort: "\(hostPort)", args: [
                    "action" : "view_event",
                    "view_id" : "\(subviewData.ID!)",
                    "event_content" : [
                        "name" : "on_resize",
                        "width" : reader.size.width,
                        "height" : reader.size.height
                    ]
                ])
            }
        }
    }
}
