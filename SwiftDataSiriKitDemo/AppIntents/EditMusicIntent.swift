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
    
    static var parameterSummary: some ParameterSummary {
        Summary("Edit \(\.$name)")
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        let musicModels:[MusicModel] = await fetchAllMusic()
        guard !musicModels.isEmpty else {
            print("Your album is empty.")
            throw MusicError.albumEmpty
        }
        guard let name = name else {
            throw $name.needsValueError("Please enter the new music name.")
        }
        print(musicModels)
        return .result(dialog: "Which music would you like to edit?") {
            MusicPickerView(musicModels: musicModels) { id in
                updateMusic(id: id, name: name)
            }
        }
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
                    print("An error occured when adding new music.")
                } else {
                    print("Successfully add new music.")
                }
            }
        }
    }
}

enum MusicError: Error {
    case albumEmpty
}

