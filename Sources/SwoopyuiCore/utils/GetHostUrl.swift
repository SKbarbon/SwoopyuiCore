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
    }else if let variableValue = getenv("custom_swoopyui_link"), let value = String(validatingUTF8: variableValue){
        let theLink = value
        if target == "target_function" {
            return "\(theLink)/start_target_function"
        } else if target == "get_updates" {
            return "\(theLink)/get_updates"
        } else if target == "push_update" {
            return "\(theLink)/push_update"
        } else if target == "stream_updates"{
            return "\(theLink)/stream_updates"
        }
        return theLink
    } else {
        urlName = "localhost"
    }
    
    if target == "target_function" {
        return "http://\(urlName):\(port)/start_target_function"
    } else if target == "get_updates" {
        return "http://\(urlName):\(port)/get_updates"
    } else if target == "push_update" {
        return "http://\(urlName):\(port)/push_update"
    } else if target == "stream_updates" {
        return "http://\(urlName):\(port)/stream_updates"
    }
    return "http://localhost:\(port)"
}

