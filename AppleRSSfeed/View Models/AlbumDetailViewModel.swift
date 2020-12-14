//
//  AlbumDetailViewModel.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import Foundation

class AlbumDetailViewModel {
    var album: Album?
    
    init(album: Album?) {
        self.album = album
    }
    
    var title: String {
        "Album"
    }
    
    var name: String {
        album?.name ?? ""
    }
    
    var artistName: String {
        album?.artistName ?? ""
    }
    
    var releaseDate: String {
        album?.releaseDate ?? ""
    }
    
    var copyRight: String {
        album?.copyright ?? ""
    }
    
    var genreLabel: String {
        guard let album = album else {
            return ""
        }
        return genreLabel(album.genres)
    }
    
    var albumUrl: URL? {
        guard let album = album, let imageURL = URL(string: album.artworkUrl100) else {
            return nil
        }
        return imageURL
    }
    
    var albumWebsiteUrl: URL? {
        guard let album = album, let url = URL(string: album.url) else {
            return nil
        }
        return url
    }
    
    var websiteViewControllerTitle: String {
        return "Apple Music"
    }
    
    /// Generates the concatenated Genre label out of Genre collection.
    func genreLabel(_ genres: [Genre]) -> String {
        var genreLabel = ""
        
        genres.forEach { (genre) in
            let divider = genreLabel.count > 0 ? " | " : ""
            genreLabel = genreLabel + divider + genre.name
        }
        return genreLabel
    }
}
