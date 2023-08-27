//
//
//  
//
//
//

import Foundation


func getHostUrl (port:Int, target:String) -> String {
    if target == "target_function" {
        return "http://localhost:\(port)/start_target_function"
    } else if target == "get_updates" {
        return "http://localhost:\(port)/get_updates"
    }
    return "http://localhost:\(port)"
}

