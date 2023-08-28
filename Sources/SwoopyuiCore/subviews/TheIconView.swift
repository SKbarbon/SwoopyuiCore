//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct TheIconView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    var body: some View {
        Image (systemName: "\(subviewData.props?.icon_name ?? "")")
            .font(.system(size: CGFloat(subviewData.props?.icon_size ?? 18)))
            .foregroundStyle(getColorByString(color: subviewData.props?.icon_color ?? "primery"))
    }
}
