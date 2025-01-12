//
//  Music.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/9.
//

import Foundation
import SwiftData
import AppIntents

@Model
class Music: Identifiable {
    var createDate: Date
    var name: String
    var id: UUID
    
    init(id: UUID = UUID(), createDate: Date = Date(), name: String) {
        self.id = id
        self.createDate = createDate
        self.name = name
    }
}

struct MusicModel: Identifiable, Sendable {
    var createDate: Date
    var name: String
    var id: UUID
    var pid: PersistentIdentifier
}

struct MusicModelEntity: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Music"
    
    var createDate: Date
    var name: String
    var id: UUID
    var pid: PersistentIdentifier
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: LocalizedStringResource(
                stringLiteral: name
            )
        )
    }
    
    static var defaultQuery = MusicQuery()
}

struct MusicQuery: EntityPropertyQuery {
}
