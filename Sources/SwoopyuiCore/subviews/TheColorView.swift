//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct TheColorView: View {
    @Binding var subviewData : SubView
    var body: some View {
        VStack {
            getColorByString(color: "\(subviewData.props?.color ?? "primery")")
                .frame(width: CGFloat(subviewData.props?.width ?? 100), height: CGFloat(subviewData.props?.height ?? 100))
                .cornerRadius(CGFloat(subviewData.props?.corner_radius ?? 0))
        }
    }
}
