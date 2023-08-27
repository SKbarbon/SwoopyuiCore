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
    var props: SubViewProps?
    var sub_views: [SubView]?
}

struct SubViewProps : Decodable, Equatable {
    
}
