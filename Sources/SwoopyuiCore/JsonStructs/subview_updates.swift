
import Foundation


struct NewHostUpdates : Decodable, Equatable {
    var updts : [SubViewUpdateRequest]?
}
 
struct SubViewUpdateRequest : Decodable, Equatable {
    var action :  String?
    
    // 'add' action data
    var to_id: String?
    var subview_data: SubView?
    
    // reverse data
    var parent_id : Int?
    var subview_id : Int?
    var new_link : String?
    var same_position : Bool?
    var new_video_state : String? // 'stop' or 'play'
    var width : Int?
    var height : Int?
}


