//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 29/08/2023.
//

import SwiftUI

struct LabeledButton: View {
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
        }){
            Label(
                title: {
                    Text("\(subviewData.props?.content ?? "")").font(.system(size: CGFloat(subviewData.props?.size ?? 18)))
                        .foregroundStyle(getColorByString(color: subviewData.props?.color ?? "primery"))
                },
                icon: {
                    Image (systemName: subviewData.props?.icon_name ?? "").font(.system(size: CGFloat(subviewData.props?.icon_size ?? 18)))
                        .foregroundStyle(getColorByString(color: subviewData.props?.icon_color ?? "primery"))
                }
            )
        }
    }
}
