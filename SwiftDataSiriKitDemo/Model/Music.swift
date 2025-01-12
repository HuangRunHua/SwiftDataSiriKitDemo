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
        let musicModels = await MusicDataBase.shared.fetchAllMusic()
        return musicModels
    }
    
    /// 实现这个方法后可以在快捷指令中预先选择默认要修改的音乐
    /// 如果选择的默认音乐被删除，此时运行该指令每次都会触发重新选择音乐的过程
    func suggestedEntities() async throws -> [MusicModel] {
        let musicModels = await MusicDataBase.shared.fetchAllMusic()
        return musicModels
    }
}


class MusicDataBase {
    static let shared: MusicDataBase = MusicDataBase()
    
    func fetchAllMusic() async -> [MusicModel] {
        let musicDataHandler = MusicDataProvider.shared.musicDataHandlerCreator()
        let allMusics:[MusicModel] = await musicDataHandler().fetchAllMusics()
        return allMusics
    }
}
