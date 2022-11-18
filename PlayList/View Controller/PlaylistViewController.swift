//
//  PlaylistViewController.swift
//  PlayList
//
//  Created by Kvng Eko on 11/15/22.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var playlistNameTextField: UITextField!
    
    @IBOutlet var playlistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        PlaylistController.shared.loadFromPersistenceStore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    
    @IBAction func addToPlaylistTapped(_ sender: Any) {
        guard let playlistName = playlistNameTextField.text,
              !playlistName.isEmpty else{return}
        PlaylistController.shared.createPlaylist(name: playlistName)
        playlistTableView.reloadData()
        playlistNameTextField.text = ""
    }
    
    // MARK: - TableView Data Source Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistTableView.dequeueReusableCell(withIdentifier: "playListCell", for: indexPath)
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        
        cell.textLabel?.text = playlist.name
        if playlist.songs.count == 1 {
            cell.detailTextLabel?.text = "\(playlist.songs.count) Song"
        } else {
            cell.detailTextLabel?.text = "\(playlist.songs.count) Songs"
        }
        return cell
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSongsList" {
            guard let indexPath = playlistTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? SongTableViewController else {return}
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            destination.playlist = playlist
            
        }
        
    }
    
    
}
