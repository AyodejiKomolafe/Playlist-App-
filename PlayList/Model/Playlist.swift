//
//  Playlist.swift
//  PlayList
//
//  Created by Kvng Eko on 11/15/22.
//

import Foundation

class Playlist : Codable {
    let name : String
    var songs : [Song]
    
    init(name: String, songs: [Song] = []) {
        self.name = name
        self.songs = songs
    }

    
   
}

extension Playlist : Equatable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.name == rhs.name && lhs.songs == rhs.songs
    }
    
    
}
