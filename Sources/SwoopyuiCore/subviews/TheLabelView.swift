//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct TheLabelView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    var body: some View {
        Label(
            title: {
                Text("\(subviewData.props?.content ?? "")")
                    .foregroundStyle(getColorByString(color: subviewData.props?.color ?? "primery"))
            },
            icon: {
                Image (systemName: subviewData.props?.icon_name ?? "")
                    .foregroundStyle(getColorByString(color: subviewData.props?.icon_color ?? "primery"))
            }
        )
    }
}

