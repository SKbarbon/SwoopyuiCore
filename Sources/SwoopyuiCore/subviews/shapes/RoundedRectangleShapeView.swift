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
    }
}

