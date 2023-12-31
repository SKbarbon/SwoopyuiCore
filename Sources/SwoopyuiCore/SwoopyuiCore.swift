// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftUI
import EventSource

public struct SwoopyuiInitApp: View {
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var hostPort : Int
    
    @State var appStarted : Bool = false // This will be true after running host's target function.
    
    @State var subviews: [SubView] = [SubView()]
    @State var hostUpdates : [SubViewUpdateRequest] = [SubViewUpdateRequest()]
    
    @State var errorMessage = ""
    
    public init(hostPort: Int) {
        self._hostPort = State(initialValue: hostPort)
    }
    public var body: some View {
        if appStarted && errorMessage == ""{
            VStack {
                ForEach (subviews, id: \.update_id) {sbv in
                    ViewGenerator(subviewData: sbv, hostUpdates: $hostUpdates, hostPort: "\(hostPort)")
                }
            }
            .onAppear() {
                // Start the stram connection
                connectToSreamUpdates()
            }
        } else if (appStarted && errorMessage != "") {
            Label("\(errorMessage)", systemImage: "info.circle")
                .bold()
                .foregroundStyle(.red)
        } else {
            HStack {
                Text("Connecting to host..")
                ProgressView()
            }
            .onAppear() {
                // Prepair for the connection before connecting.
                runHostTargetFunction(port: hostPort)
                Thread.sleep(forTimeInterval: 0.3)
                pushStartupAppInfo()
                appStarted = true
            }
        }
    }
    func connectToSreamUpdates () {
        Task {
            let urlRequest = URLRequest(url: URL(string: getHostUrl(port: hostPort, target: "stream_updates"))!)
            let eventSource = EventSource(request: urlRequest)
            eventSource.connect()
            
            for await event in eventSource.events {
                switch event {
                case .open:
                    print("Stream Connection was opened.")
                case .error(let error):
                    print("Received an error:", error.localizedDescription)
                case .message(let message):
                    loadJsonOfUpdateRequest(content: message.data!)
//                    print("Received a message", message.data ?? "")
                case .closed:
                    print("Stream Connection was closed.")
                    errorMessage = "Connection to host is closed."
                }
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
                var num = 0
                
                hostUpdates.removeAll()
                for u in jsonProduct.updts! {
                    if (u.action == "add_subview" && u.to_id == "main") {
                        subviews.append(u.subview_data!)
                    }else if u.action == "update_subview" {
                        if updateSubviewProps(updat: u, num: num) == false {
                            hostUpdates.append(u)
                        }
                        
                    } else if (u.action == "host_error") {
                        errorMessage = u.error_message ?? ""
                    } else {
                        hostUpdates.append(u)
                    }
                    num = num + 1
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Invalid JSON data")
        }
    }
    func updateSubviewProps (updat:SubViewUpdateRequest, num:Int) -> Bool{
        var newSubviewsList : [SubView] = []
        var foundIt = false
        for sv in subviews {
            if sv.ID == updat.subview_data?.ID {
                newSubviewsList.append(updat.subview_data!)
                foundIt = true
            } else {
                newSubviewsList.append(sv)
            }
        }
        subviews = newSubviewsList
        return foundIt
    }
    
    func pushStartupAppInfo () {
        #if os(macOS)
        pushClientUpdate(hostPort: String(hostPort), args: [
            "action" : "startup_app_info",
            "content" : [
                "platform" : "macOS"
            ]
        ])
        #else
        pushClientUpdate(hostPort: String(hostPort), args: [
            "action" : "startup_app_info",
            "content" : [
                "platform" : "\(UIDevice.current.systemName)"
            ]
        ])
        #endif
    }
    func processClearingStoredUpdatesMethod () {
        var all_latest_ids_with_updateids : [Int:Int] = [:]
        var newUpdatesList : [SubViewUpdateRequest] = []
        for u in hostUpdates {
            if u.action == "update_subview" {
                let currentID = u.subview_data?.ID!
                let currentUpdateId = u.subview_data?.update_id!
                all_latest_ids_with_updateids[currentID!] = currentUpdateId!
            }
        }
        
        for uu in hostUpdates {
            if uu.action == "update_subview" {
                let currentID = uu.subview_data?.ID!
                let currentUpdateId = uu.subview_data?.update_id!
                if all_latest_ids_with_updateids[currentID!] == currentUpdateId {
                    newUpdatesList.append(uu)
                }
            } else {
                newUpdatesList.append(uu)
            }
        }
        hostUpdates = newUpdatesList
    }
}

