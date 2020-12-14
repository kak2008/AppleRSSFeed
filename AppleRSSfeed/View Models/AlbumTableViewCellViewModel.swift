//
//  AlbumTableViewCellViewModel.swift
//  AppleRSSfeed
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import Foundation

class AlbumTableViewCellViewModel {
    var albumInformation: AlbumCellInformation?
    
    init(_ albumInfo: AlbumCellInformation) {
        albumInformation = albumInfo
    }
    
    var name: String {
        albumInformation?.name ?? ""
    }
    
    var artist: String {
        albumInformation?.artist ?? ""
    }
    
    var albumImageUrl: URL? {
        guard let imageString = albumInformation?.albumImage, let url = URL(string: imageString) else {
            return nil
        }
        return url
    }
}
