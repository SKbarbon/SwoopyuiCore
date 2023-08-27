//
//  File.swift
//  
//
//  Created by Yousif Aladwani on 27/08/2023.
//

import Foundation

func makeHttpPostRequest(with dictionary: [String: Any], to url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        request.httpBody = jsonData
    } catch {
        completion(nil, nil, error)
        return
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        completion(data, response, error)
    }
    
    task.resume()
}


func pushClientUpdate (hostPort:String, args: [String: Any]) {
    // Example usage
    let urlString = getHostUrl(port: Int(hostPort)!, target: "push_update")
    let dictionary: [String: Any] = args
    if let url = URL(string: urlString) {
        makeHttpPostRequest(with: dictionary, to: url) { data, response, error in
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
            }
            if let error = error {
                print("Error: \(error)")
            }
        }
    } else {
        print("Invalid URL")
    }

}

