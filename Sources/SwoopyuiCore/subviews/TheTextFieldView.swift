//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct TheTextFieldView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    
    @State var textfildContent = ""
    var body: some View {
        if subviewData.props?.resizeable == true {
            TextField("\(subviewData.props?.placeholder ?? "")", text: $textfildContent)
                .foregroundStyle(getColorByString(color: subviewData.props?.color ?? "primery"))
                .frame(width: CGFloat(subviewData.props?.width ?? 100), height: CGFloat(subviewData.props?.height ?? 40))
                .onChange (of: textfildContent){_ in
                    pushNewEdits()
            }
                .onAppear() {
                    textfildContent = "\(subviewData.props?.content ?? "")"
                }
        } else if subviewData.props?.resizeable == false {
            TextField("\(subviewData.props?.placeholder ?? "")", text: $textfildContent)
                .foregroundStyle(getColorByString(color: subviewData.props?.color ?? "primery"))
                .onChange (of: textfildContent){_ in
                    pushNewEdits()
            }
                .onAppear() {
                    textfildContent = "\(subviewData.props?.content ?? "")"
                }
        }
    }
    func pushNewEdits () {
        pushClientUpdate(hostPort: hostPort, args: [
            "action" : "view_event",
            "view_id" : subviewData.ID!,
            "event_content" : [
                "name" : "on_change",
                "content" : "\(textfildContent)"
        ]
    ])
    }
}
