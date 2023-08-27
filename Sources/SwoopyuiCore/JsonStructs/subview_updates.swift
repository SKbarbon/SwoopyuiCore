
import Foundation


 
struct SubViewUpdateRequest : Decodable, Equatable {
    var action :  String?
    
    // 'add' action data
    var to_id: Int?
    var subview_data: SubView?
}

