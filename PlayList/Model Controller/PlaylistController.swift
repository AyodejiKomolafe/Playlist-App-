//
//  PlaylistController.swift
//  PlayList
//
//  Created by Kvng Eko on 11/15/22.
//

import Foundation

class PlaylistController {
    static let shared = PlaylistController()
    
    //source of truth
    
    var playlists : [Playlist] = []
    
    //CRUD
    
    //Create
    func createPlaylist(name: String) {
        let newPlaylist = Playlist(name: name)
        playlists.append(newPlaylist)
        saveToPersistenceStore() 
    }
    
    //Delete
    func delettePlaylist(playlist : Playlist) {
        guard let index = playlists.firstIndex(of: playlist) else{return}
        playlists.remove(at: index)
        saveToPersistenceStore()
    }
    
    //Persistence
    
    // Persistence Store
    
    func persistenceStore() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl = urls[0].appendingPathComponent("Playlist.json")
        
        return fileUrl
    }
    
    
    
    
    // Save
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(playlists)
            try data.write(to: persistenceStore())
        } catch {
            print("we had an error saving to our persistence store.")
            print(error)
            print(error.localizedDescription)
            
        }
    }
    
    // Load
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: persistenceStore())
            let fetchedPlaylist = try JSONDecoder().decode([Playlist].self, from: data)
            playlists = fetchedPlaylist
        } catch {
            
            print("we had an error loading our persistence store")
            print(error)
            print(error.localizedDescription)
            
        }
    }
    
}
