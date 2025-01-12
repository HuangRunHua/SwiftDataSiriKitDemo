//
//  ContentView.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/9.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query(sort: \Music.createDate, order: .reverse) private var musics: [Music]
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List(musics) { music in
                Text(music.name)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteMusic(music: music)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            .navigationTitle("Music")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addNewMusic()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func addNewMusic() {
        let newMusic: Music = Music(name: "Music \(musics.count + 1)")
        modelContext.insert(newMusic)
        do {
            try modelContext.save()
        } catch {
            print("Error occured when saving modelContext: \(error)")
        }
    }
    
    func deleteMusic(music: Music) {
        modelContext.delete(music)
        do {
            try modelContext.save()
        } catch {
            print("Error occured when deleting music: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
