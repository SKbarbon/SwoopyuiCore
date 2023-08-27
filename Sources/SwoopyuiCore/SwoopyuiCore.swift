// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftUI


public struct SwoopyuiInitApp: View {
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var hostPort : Int
    
    @State var appStarted : Bool = false // This will be true after running host's target function.
    
    @State var subviews: [SubView] = [SubView()]
    @State var hostUpdates : [SubViewUpdateRequest] = [SubViewUpdateRequest()]
    
    public init(hostPort: Int) {
        self._hostPort = State(initialValue: hostPort)
    }
    public var body: some View {
        if appStarted {
            VStack {
                ForEach (subviews, id: \.update_id) {sbv in
                    ViewGenerator(subviewData: sbv, hostUpdates: $hostUpdates)
                }
            }
            .onReceive(timer){_ in
                httpGetUpdatesRequest()
            }
        } else {
            HStack {
                Text("Connecting to host..")
                ProgressView()
            }
            .onAppear() {
                runHostTargetFunction(port: hostPort)
                appStarted = true
            }
        }
    }
    func httpGetUpdatesRequest () {
        // Create a URL
        if let url = URL(string: getHostUrl(port: hostPort, target: "get_updates")) {
            // Create a URLSession
            let session = URLSession.shared
            
            // Create a data task
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    appStarted = false
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    if let stringData = String(data: data, encoding: .utf8) {
                        appStarted = true
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
                let jsonProduct = try JSONDecoder().decode(NewHostUpdates.self, from: jsonData)
                for u in jsonProduct.updts! {
                    if (u.action == "add_subview" && u.to_id == "main") {
                        subviews.append(u.subview_data!)
                    } else {
                        print(u)
                        hostUpdates.append(u)
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Invalid JSON data")
        }
    }
}

