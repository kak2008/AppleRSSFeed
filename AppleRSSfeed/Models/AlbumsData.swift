//
//  AlbumsData.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import Foundation

struct AlbumsData: Codable {
    var feed: Feed
}

struct Feed: Codable {
    var title: String
    var id: String
    var country: String
    var results: [Album]
}

struct Album: Codable {
    var artistName: String
    var id: String
    var releaseDate: String
    var name: String
    var kind: String
    var copyright: String
    var artistId: String
    var artistUrl: String
    var artworkUrl100: String
    var url: String
    var genres: [Genre]
}

struct Genre: Codable {
    var genreId: String
    var name: String
    var url: String
}
