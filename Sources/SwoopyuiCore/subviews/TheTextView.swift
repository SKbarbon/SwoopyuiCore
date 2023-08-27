//
//
//  
//
//  
//

import SwiftUI

struct TheTextView: View {
    @Binding var subviewData : SubView
    var body: some View {
        Text("\(subviewData.props?.content ?? "")")
            .foregroundStyle(getColorByString(color: subviewData.props?.color ?? "pr"))
            .font(.system(size: CGFloat(subviewData.props?.size ?? 18)))
    }
}
