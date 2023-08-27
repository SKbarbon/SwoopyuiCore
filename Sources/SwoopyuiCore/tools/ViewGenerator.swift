//
//
//  
//
//
//

import SwiftUI

struct ViewGenerator: View {
    @State var subviewData : SubView
    @Binding var hostUpdates : [SubViewUpdateRequest]
    var body: some View {
        VStack {
            if  subviewData.name == "Text" {
                TheTextView(subviewData: $subviewData)
            }
        }
        .onChange (of: hostUpdates){_ in
            
        }
    }
}
