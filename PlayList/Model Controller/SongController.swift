//
//  SongController.swift
//  PlayList
//
//  Created by Kvng Eko on 11/14/22.
//

import Foundation

class SongController {
    
    //CRUD
    
    //Create
    static func createSong(tittle : String, artistName : String, playlist : Playlist) {
        let newSong = Song(title: tittle, artistName: artistName)
        playlist.songs.append(newSong)
        PlaylistController.shared.saveToPersistenceStore()
        
    }
    
    //Delete
    
    static func deleteSong(song: Song, playlist : Playlist) {
        guard let index = playlist.songs.firstIndex(of: song) else{return}
        playlist.songs.remove(at: index)
        PlaylistController.shared.saveToPersistenceStore()
    }
    
    
}
