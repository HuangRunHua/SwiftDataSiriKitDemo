//
//  AddMusicIntent.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/11.
//

import SwiftUI
import AppIntents
import SwiftData

struct AddMusicIntent: AppIntent {
    
    static var title = LocalizedStringResource("Add Music")
    static var description = IntentDescription("Adds a new music to local album.")
    
    @Parameter(title: "Name")
    var name: String?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Add \(\.$name)")
    }
    
    func perform() async throws -> some IntentResult {
        guard let name = name else {
            throw $name.needsValueError()
        }
        self.addNewMusic(name: name)
        return .result()
    }
    
    /// 添加新的音乐到专辑中
    private func addNewMusic(name: String) {
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
}
