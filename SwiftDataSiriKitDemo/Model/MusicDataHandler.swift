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
public actor MusicDataHandler {
    public func addNewMusic(
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
}
