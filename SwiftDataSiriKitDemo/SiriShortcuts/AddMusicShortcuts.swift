//
//  AddMusicShortcuts.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/13.
//

import AppIntents

struct AddMusicShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddMusicIntent(),
            phrases: [
                "在\(.applicationName)中添加新音乐.",
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "添加新音乐到专辑中"),
            systemImageName: "plus"
        )
    }
}
