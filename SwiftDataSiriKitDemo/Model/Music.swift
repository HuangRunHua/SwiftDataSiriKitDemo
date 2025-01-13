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
    /// 未选择默认音乐的时候会先调用suggestedEntities方法向用户列举所有可选择的音乐
    /// 用户选择其中一个或多个实体后将会调用entities(for:)方法
    /// 此时将会返回这些实体实例的数组用于后续处理
    func entities(
        for identifiers: [UUID] = []
    ) async throws -> [MusicModel] {
        let musicModels = await MusicDataBase.shared.fetchAllMusic()
        return musicModels.filter({ identifiers.contains($0.id) })
    }
    
    /// 这个方法有两个作用：
    /// - 1. 可以在指令执行的时候选择对应的音乐实体
    /// - 2. 可以在快捷指令中预先选择默认要修改的音乐
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
    
    /// 添加新的音乐到专辑中
    func updateMusic(id: PersistentIdentifier, name: String) {
        let musicDataHandler = MusicDataProvider.shared.musicDataHandlerCreator()
        Task.detached {
            let addResult = await musicDataHandler().updateMusic(id: id, name: name)
            await MainActor.run {
                if !addResult {
                    print("An error occured when updating music's name.")
                } else {
                    print("Successfully update music's name to《\(name)》.")
                }
            }
        }
    }
    
    /// 添加新的音乐到专辑中
    func addNewMusic(name: String) {
        let musicDataHandler = MusicDataProvider.shared.musicDataHandlerCreator()
        Task.detached {
            let addResult = await musicDataHandler().addNewMusic(name: name)
            await MainActor.run {
                if !addResult {
                    print("An error occured when adding new music.")
                } else {
                    print("Successfully add new music.")
                }
            }
        }
    }
    
    func deleteMusic(id: PersistentIdentifier) {
        let musicDataHandler = MusicDataProvider.shared.musicDataHandlerCreator()
        Task.detached {
            let addResult = await musicDataHandler().deleteMusic(id)
            await MainActor.run {
                if !addResult {
                    print("An error occured when deleting music.")
                } else {
                    print("Successfully delete music.")
                }
            }
        }
    }
}
