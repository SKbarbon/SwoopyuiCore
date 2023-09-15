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
    var sub_views3: [SubView]?
    var sub_views4: [SubView]?
}

struct SubViewProps : Decodable, Equatable {
    var content: String?
    var color: String?
    var size: Int?
    var title: String?
    var detail_title: String?
    var placeholder: String?
    var resizeable: Bool?
    var width : Int?
    var height: Int?
    var scrollMode : String?
    var corner_radius: Int?
    var presented : Bool?
    var bgcolor : String?
    var icon_name: String?
    var icon_color : String?
    var icon_size: Int?
    var link : String?
    var padding: Int?
    var bold : Bool?
}
