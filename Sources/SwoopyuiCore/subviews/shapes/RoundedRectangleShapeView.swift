//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct RoundedRectangleShapeView: View {
    @Binding var subviewData : SubView
    var body: some View {
        RoundedRectangle(cornerRadius: CGFloat(subviewData.props?.corner_radius ?? 0))
            .foregroundStyle(getColorByString(color: subviewData.props?.color ?? "primery"))
            .frame(width: CGFloat(subviewData.props?.width ?? 100), height: CGFloat(subviewData.props?.height ?? 100))
    }
}

