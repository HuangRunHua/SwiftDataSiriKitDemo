//
//  MusicDataProvider.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/11.
//

import SwiftData
import SwiftUI

final public class MusicDataProvider: Sendable {
    static public let shared = MusicDataProvider()

    public let sharedModelContainer: ModelContainer = {
        let schema = Schema([Music.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    public init() {}
    
    public func musicDataHandlerCreator() -> @Sendable () async -> MusicDataHandler {
        let container = sharedModelContainer
        return { MusicDataHandler(modelContainer: container) }
    }
}

struct MusicDataHandlerKey: EnvironmentKey {
    static public let defaultValue: @Sendable () async -> MusicDataHandler? = { nil }
}

extension EnvironmentValues {
    public var musicDataHandler: @Sendable () async -> MusicDataHandler? {
        get { self[MusicDataHandlerKey.self] }
        set { self[MusicDataHandlerKey.self] = newValue }
    }
}


