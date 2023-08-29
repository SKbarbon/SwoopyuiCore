//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 29/08/2023.
//

import SwiftUI

struct TheMenuView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        Menu ("\(subviewData.props?.title ?? "")") {
            ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
            }
        }
    }
}
