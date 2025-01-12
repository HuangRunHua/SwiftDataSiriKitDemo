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

struct MusicModel: Identifiable, Sendable, AppEntity {
    var createDate: Date
    var name: String
    var id: UUID
    var pid: PersistentIdentifier
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Music"
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: LocalizedStringResource(
                stringLiteral: name
            )
        )
    }
    
    static var defaultQuery = MusicQuery()
}

struct MusicQuery: EntityQuery {
    func entities(for identifiers: [MusicModel.ID] = []) async throws -> [MusicModel] {
        let musicModels = await self.fetchAllMusic()
        return musicModels
    }
    
    private func fetchAllMusic() async -> [MusicModel] {
        let musicDataHandler = MusicDataProvider.shared.musicDataHandlerCreator()
        let allMusics:[MusicModel] = await musicDataHandler().fetchAllMusics()
        return allMusics
    }

}
