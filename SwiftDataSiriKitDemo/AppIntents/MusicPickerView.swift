//
//  MusicPickerView.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/12.
//

import SwiftUI
import SwiftData

struct MusicPickerView: View {
    var musicModels: [MusicModel]
    var selectedAction: (_ id: PersistentIdentifier) -> Void
    var body: some View {
        // 提供音乐列表选项
        List(musicModels) { musicModel in
            Button(action: {
                selectedAction(musicModel.pid)
            }) {
                Text(musicModel.name)
            }
        }
    }
}
