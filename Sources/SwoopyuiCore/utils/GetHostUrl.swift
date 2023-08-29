//
//
//  
//
//
//

import Foundation


func getHostUrl (port:Int, target:String) -> String {
    var urlName = ""
    if let variableValue = getenv("hostUrlName"), let value = String(validatingUTF8: variableValue) {
        urlName = "\(value)"
    } else {
        urlName = "localhost"
    }
    
    if target == "target_function" {
        return "http://\(urlName):\(port)/start_target_function"
    } else if target == "get_updates" {
        return "http://\(urlName):\(port)/get_updates"
    } else if target == "push_update" {
        return "http://\(urlName):\(port)/push_update"
    }
    return "http://localhost:\(port)"
}

