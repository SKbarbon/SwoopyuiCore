//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct TextButtonView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        Button ("\(subviewData.props?.content ?? "")"){
            pushClientUpdate(hostPort: "\(hostPort)", args: [
                "action" : "view_event",
                "view_id" : "\(subviewData.ID!)",
                "event_content" : [
                    "name" : "on_click"
                ]
            ])
        }
    }
}
