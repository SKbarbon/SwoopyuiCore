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
    }
}
