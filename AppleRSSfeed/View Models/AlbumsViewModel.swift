//
//  AlbumsViewModel.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import Foundation

protocol AlbumsDataDelegate {
    func albumsDataRetrieved()
}

class AlbumsViewModel {
    var viewTitle = "Albums"
    var delegate: AlbumsDataDelegate?
    var albums: [Album]?
    var networkCommunicator: NetworkCommunicator?
    
    init(delegate: AlbumsDataDelegate, networkCommunicator: NetworkCommunicator = .shared) {
        self.delegate = delegate
        self.networkCommunicator = networkCommunicator
    }
    
    var numberOfRows: Int {
        albums?.count ?? 0
    }

    func getAlbumsData() {
        networkCommunicator?.getAlbumsData { (albums, error) in
            guard error == nil else { return }
            self.albums = albums
            self.delegate?.albumsDataRetrieved()
        }
    }
    
    func cellViewModel(for indexpath: IndexPath) -> AlbumTableViewCellViewModel? {
        guard let album = albums?[indexpath.row] else { return nil }
        let albumInformation = AlbumCellInformation(name: album.name,
                                                    artist: album.artistName,
                                                    albumImage: album.artworkUrl100)
        let albumViewModel = AlbumTableViewCellViewModel(albumInformation)
        return albumViewModel
    }
}
