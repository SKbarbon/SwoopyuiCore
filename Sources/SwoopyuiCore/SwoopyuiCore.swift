// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftUI


public struct MyView: View {
    @State var hostPort : Int
    
    @State var subviews: [SubView] = [SubView()]
    
    public init(hostPort: Int) {
        self._hostPort = State(initialValue: hostPort)
    }
    public var body: some View {
        VStack {
            
        }
        .onAppear() {
            httpGetUpdatesRequest()
        }
    }
    func httpGetUpdatesRequest () {
        // Create a URL
        if let url = URL(string: getHostUrl(port: hostPort)) {
            // Create a URLSession
            let session = URLSession.shared
            
            // Create a data task
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    if let stringData = String(data: data, encoding: .utf8) {
                        loadJsonOfUpdateRequest(content: stringData)
                    }
                }
            }
            
            // Start the task
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    func loadJsonOfUpdateRequest (content:String) {
        let jsonString = content
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // Decode JSON data into the Person struct
                let jsonProduct = try JSONDecoder().decode(SubViewUpdateRequest.self, from: jsonData)
                if jsonProduct.action == "add_subview" {
                    subviews.append(jsonProduct.subview_data!)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Invalid JSON data")
        }
    }
}

