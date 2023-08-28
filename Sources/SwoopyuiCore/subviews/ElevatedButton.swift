//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct ElevatedButton: View {
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
                    ZStack {
                        getColorByString(color: "\(subviewData.props?.bgcolor ?? "primery")")
                            .frame(width: CGFloat(subviewData.props?.width ?? 30), height: CGFloat(subviewData.props?.height ?? 30))
                            .cornerRadius(12)
                        Text("\(subviewData.props?.content ?? "")").bold()
                            .foregroundColor(getColorByString(color: subviewData.props?.color ?? "primery"))
            }
        }
    }
}
