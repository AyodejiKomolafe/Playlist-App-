//
//  SongTableViewController.swift
//  PlayList
//
//  Created by Kvng Eko on 11/14/22.
//

import UIKit


class SongTableViewController: UITableViewController {
    
    
    @IBOutlet var songTitleTextField: UITextField!
    
    @IBOutlet var artistNameTextField: UITextField!
    
    // MARK: Properties
    
    var playlist : Playlist?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text,
              let artistName = artistNameTextField.text,
              !songTitle.isEmpty,
              !artistName.isEmpty,
              let playlist = playlist else{return}
        
        SongController.createSong(tittle: songTitle, artistName: artistName, playlist: playlist)
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playlist?.songs.count ?? 0
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        guard let playlist = playlist else {return cell}
        
        let song = playlist.songs[indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artistName
        
        return cell
    }
    
    
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else {return}
            let songToDelete = playlist.songs[indexPath.row]
            SongController.deleteSong(song: songToDelete, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
}
