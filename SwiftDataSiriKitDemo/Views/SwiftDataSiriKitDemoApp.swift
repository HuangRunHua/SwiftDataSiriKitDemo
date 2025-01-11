//
//  SwiftDataSiriKitDemoApp.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/9.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataSiriKitDemoApp: App {
    let musicDataProvider = MusicDataProvider.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(musicDataProvider.sharedModelContainer)
    }
}
