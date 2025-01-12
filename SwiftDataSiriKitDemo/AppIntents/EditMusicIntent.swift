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
        let musicModels:[MusicModel] = await MusicDataBase.shared.fetchAllMusic()
        guard !musicModels.isEmpty else {
            throw MusicError.albumEmpty
        }
        
        guard let music = music else {
            throw $music.needsValueError("Please selected your target music.")
        }
        
        guard let name = name else {
            throw $name.needsValueError("Please enter the new music name.")
        }
        
        MusicDataBase.shared.updateMusic(id: music.pid, name: name)
        
        return .result()
    }
}

enum MusicError: Swift.Error, CustomLocalizedStringResourceConvertible {
    case albumEmpty

    var localizedStringResource: LocalizedStringResource {
        switch self {
            case .albumEmpty: return "No music found in your album."
        }
    }
}

