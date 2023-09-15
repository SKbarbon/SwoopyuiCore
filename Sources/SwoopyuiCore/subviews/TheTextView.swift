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
        if subviewData.props?.bold == true {
            Text("\(subviewData.props?.content ?? "")")
                .font(.system(size: CGFloat(subviewData.props?.size ?? 18)))
                .bold()
                .foregroundStyle(getColorByString(color: subviewData.props?.color ?? "primery"))
        } else {
            Text("\(subviewData.props?.content ?? "")")
                .foregroundStyle(getColorByString(color: subviewData.props?.color ?? "primery"))
                .font(.system(size: CGFloat(subviewData.props?.size ?? 18)))
        }
    }
}
