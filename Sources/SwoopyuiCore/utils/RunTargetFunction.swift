//
//
//  
//
//
//

import Foundation

func runHostTargetFunction (port:Int) {
    // Create a URL
    if let url = URL(string: getHostUrl(port: port, target: "start_target_function")) {
        // Create a URLSession
        let session = URLSession.shared
        
        // Create a data task
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                if let _ = String(data: data, encoding: .utf8) {
                    
                }
            }
        }
        
        // Start the task
        task.resume()
    } else {
        print("Invalid URL")
    }
}
