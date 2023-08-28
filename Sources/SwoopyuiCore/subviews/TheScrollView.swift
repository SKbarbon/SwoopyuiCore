//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct TheScrollView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    var body: some View {
        if subviewData.props?.scrollMode == "vertical" {
            ScrollView (.vertical) {
                VStack {
                    ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                        ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
                    }
                }
            }
        } else if subviewData.props?.scrollMode == "horizontal" {
            ScrollView (.horizontal) {
                HStack {
                    ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                        ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
                    }
                }
            }
        }
    }
}
