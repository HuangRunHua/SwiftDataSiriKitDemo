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
    
    @Environment(\.musicDataHandler) private var musicDataHandler
    
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
    
    private func addNewMusic(name: String) {
        let musicDataHandler = musicDataHandler
        Task.detached {
            if let dataHandler = await musicDataHandler() {
                let addResult = await dataHandler.addNewMusic(name: name)
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
}
