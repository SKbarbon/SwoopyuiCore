//
//  SwiftUIView.swift
//  
//
//
//

import SwiftUI

struct TheSwitchView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    
    @State var isActive : Bool = false
    var body: some View {
        if subviewData.props?.with_no_labels == true {
            Toggle("", isOn: $isActive)
                .labelsHidden()
                .onAppear() {setOriginalState()}
                .onChange(of: isActive) {_ in pushTogleEvent()}
        } else {
            Toggle(subviewData.props?.content ?? "", isOn: $isActive)
                .onAppear() {setOriginalState()}
                .onChange(of: isActive) {_ in pushTogleEvent()}
        }
    }
    func setOriginalState () {
        isActive = subviewData.props?.activated ?? false
    }
    func pushTogleEvent () {
        pushClientUpdate(hostPort: "\(hostPort)", args: [
            "action" : "view_event",
            "view_id" : "\(subviewData.ID!)",
            "event_content" : [
                "name" : "on_change",
                "active" : isActive
            ]
        ])
    }
}

