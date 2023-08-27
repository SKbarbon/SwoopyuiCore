//
//  File.swift
//  
//
//  Created by Yousif Aladwani on 27/08/2023.
//

import Foundation
import SwiftUI

func getColorByString (color:String) -> Color {
    if color == "red" {
        return Color.red
    } else if color == "pink" {
        return Color.pink
    } else if color == "blue" {
        return Color.blue
    } else if color == "white" {
        return Color.white
    } else if color == "black" {
        return Color.black
    } else if color == "orange" {
        return Color.orange
    } else if color == "yellow" {
        return Color.yellow
    } else if color == "purple" {
        return Color.purple
    }
    
    return Color.primary
}
