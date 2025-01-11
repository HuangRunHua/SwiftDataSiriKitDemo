//
//  Music.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/9.
//

import Foundation
import SwiftData

@Model
class Music {
    var createDate: Date
    var name: String
    
    init(createDate: Date = Date(), name: String) {
        self.createDate = createDate
        self.name = name
    }
}
