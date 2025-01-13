//
//  ContentView.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/9.
//

import SwiftUI
import SwiftData
import AppIntents

struct ContentView: View {
    
    @Query(sort: \Music.createDate, order: .reverse) private var musics: [Music]
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    SiriTipView(intent: EditMusicIntent())
                        .siriTipViewStyle(.dark)
                }
                
                ForEach(musics) { music in
                    Text(music.name)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                MusicDataBase.shared.deleteMusic(id: music.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .navigationTitle("Music")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let name: String = "Music \(musics.count)"
                        MusicDataBase.shared.addNewMusic(name: name)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
