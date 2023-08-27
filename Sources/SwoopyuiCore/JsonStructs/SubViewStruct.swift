//
//  File.swift
//  
//
//  Created by Yousif Aladwani on 27/08/2023.
//

import Foundation



struct SubView : Decodable, Equatable {
    var ID : Int?
    var update_id: Int?
    var name: String?
    var props: SubViewProps?
    var sub_views: [SubView]?
    var sub_views2: [SubView]?
}

struct SubViewProps : Decodable, Equatable {
    var content: String?
    var color: String?
    var size: Int?
}
