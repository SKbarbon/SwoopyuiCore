
import Foundation


struct NewHostUpdates : Decodable, Equatable {
    var updts : [SubViewUpdateRequest]?
}
 
struct SubViewUpdateRequest : Decodable, Equatable {
    var action :  String?
    
    // 'add' action data
    var to_id: String?
    var subview_data: SubView?
}


