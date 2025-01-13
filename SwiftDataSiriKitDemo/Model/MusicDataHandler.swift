//
//  MusicDataHandler.swift
//  SwiftDataSiriKitDemo
//
//  Created by Runhua Huang on 2025/1/11.
//

import Foundation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "MusicDataHandler", category: "Music Data Handler")


@ModelActor
actor MusicDataHandler {
    func addNewMusic(
        name: String
    ) -> Bool {
        let newMusic: Music = Music(name: name)
        modelContext.insert(newMusic)
        do {
            try modelContext.save()
            return true
        } catch {
            logger.error("Error occured when saving new music: \(error)")
            return false
        }
    }
    
    func updateMusic(
        id: PersistentIdentifier,
        name: String
    ) -> Bool {
        guard let music: Music = self.modelContext.existingModel(for: id) else {
            logger.error("Object Not Exist...")
            return false
        }
        music.name = name
        do {
            try modelContext.save()
            return true
        } catch {
            logger.error("Update music failed: \(error)")
            return false
        }
    }
    
    func deleteMusic(
        _ id: PersistentIdentifier
    ) -> Bool {
        guard let music: Music = self.modelContext.existingModel(for: id) else {
            logger.error("Object Not Exist...")
            return false
        }
        modelContext.delete(music)
        do {
            try modelContext.save()
            return true
        } catch {
            logger.error("Deleting music failed: \(error)")
            return false
        }
    }
    
    func fetchAllMusics() -> [MusicModel] {
        let descriptor:FetchDescriptor<Music> = self.getAllMusicsDescriptor()
        do {
            let musics = try modelContext.fetch(descriptor)
            let musicModels: [MusicModel] = musics.map { music in
                MusicModel(
                    createDate: music.createDate,
                    name: music.name,
                    id: music.id,
                    pid: music.persistentModelID
                )
            }
            return musicModels
        } catch {
            logger.error("Failed to fetch all musics 'cause: \(error)")
            return []
        }
    }
}

extension MusicDataHandler {
    private func getAllMusicsDescriptor() -> FetchDescriptor<Music> {
        let predicate = #Predicate<Music> { music in
            return 1 == 1
        }
        let fetchDescriptor = FetchDescriptor<Music>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.createDate, order: .reverse)]
        )
        return fetchDescriptor
    }
}

extension ModelContext {
    func existingModel<T>(for objectID: PersistentIdentifier) -> T? where T: PersistentModel {
        if let registered: T = registeredModel(for: objectID) {
            return registered
        }
        
        let fetchDescriptor = FetchDescriptor<T>(predicate: #Predicate {
            $0.persistentModelID == objectID
        })
    
        do {
            return try fetch(fetchDescriptor).first
        } catch {
            return nil
        }
    }
}
