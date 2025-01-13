//
//  MusicSiriShortcuts.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/13.
//

import AppIntents

struct MusicSiriShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] = [
        AppShortcut(
            intent: AddMusicIntent(),
            phrases: [
                "在\(.applicationName)中添加新音乐",
                "添加新音乐到\(.applicationName)中",
                "添加\(\.$name)到\(.applicationName)中"
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "添加新音乐到专辑中"),
            systemImageName: "plus"
        ),
        AppShortcut(
            intent: EditMusicIntent(),
            phrases: [
                "在\(.applicationName)中修改音乐的名称",
            ],
            shortTitle: LocalizedStringResource(stringLiteral: "修改某一个音乐专辑的名称"),
            systemImageName: "slider.horizontal.3"
        )
    ]
}
