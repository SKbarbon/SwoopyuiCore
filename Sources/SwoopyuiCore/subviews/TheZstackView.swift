//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 15/09/2023.
//

import SwiftUI

struct TheZstackView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        ZStack {
            ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
            }
        }.padding(CGFloat(subviewData.props?.padding ?? 0))
    }
}
