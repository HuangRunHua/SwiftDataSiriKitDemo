//
//  EditMusicIntent.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/12.
//

import SwiftUI
import AppIntents
import SwiftData

struct EditMusicIntent: AppIntent {
    
    static var title = LocalizedStringResource("Edit Music")
    static var description = IntentDescription("Edit and change target music's name.")
    
    @Parameter(title: "Name")
    var name: String?
    
    @Parameter(title: "Music")
    var music: MusicModel?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Change \(\.$music)'s name to \(\.$name)")
    }
    
    func perform() async throws -> some IntentResult {
        let musicModels:[MusicModel] = await fetchAllMusic()
        guard !musicModels.isEmpty else {
            print("Your album is empty.")
            throw MusicError.albumEmpty
        }
        
        guard let music = music else {
            throw $music.needsValueError("Please selected your target music.")
        }
        
        guard let name = name else {
            throw $name.needsValueError("Please enter the new music name.")
        }
        
        self.updateMusic(id: music.pid, name: name)
        
        return .result()
    }
    
    private func fetchAllMusic() async -> [MusicModel] {
        let musicDataHandler = MusicDataProvider.shared.musicDataHandlerCreator()
        let allMusics:[MusicModel] = await musicDataHandler().fetchAllMusics()
        return allMusics
    }
    
    /// 添加新的音乐到专辑中
    private func updateMusic(id: PersistentIdentifier, name: String) {
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
}

enum MusicError: Error {
    case albumEmpty
}

