//
//  File.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 12/08/2021.
//

import Foundation

enum Segment: String, Identifiable {
    case web = "Web"
    case smart = "Smart"
    
    var id: Segment { self }
}
