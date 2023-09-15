//
//  SwiftUIView.swift
//  
//
//  Created by Yousif Aladwani on 28/08/2023.
//

import SwiftUI

struct TheSheetView: View {
    @Binding var subviewData : SubView
    @Binding var subviewupdates : [SubViewUpdateRequest]
    @State var hostPort : String
    
    @State var isSheetPresented = false
    var body: some View {
        Text("")
        .onAppear() {
            isSheetPresented = subviewData.props?.presented ?? true
        }
        .sheet (isPresented: $isSheetPresented) {
            ForEach (subviewData.sub_views!, id: \.update_id) {subv in
                ViewGenerator(subviewData: subv, hostUpdates: $subviewupdates, hostPort: hostPort)
            }
        }
    }
}
