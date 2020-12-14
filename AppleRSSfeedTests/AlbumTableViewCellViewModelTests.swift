//
//  AlbumTableViewCellViewModelTests.swift
//  AppleRSSfeedTests
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import XCTest
@testable import AppleRSSfeed

class AlbumTableViewCellViewModelTests: XCTestCase {
    
    var viewModel: AlbumTableViewCellViewModel?
    let mockAlbumInfo = AlbumCellInformation(name: "Pop music", artist: "Mike", albumImage: "http://abcd.image.png")
    
    override func setUp() {
        super.setUp()
        
        viewModel = AlbumTableViewCellViewModel(mockAlbumInfo)
    }
    
    func test_name() {
        XCTAssertEqual(viewModel?.name, mockAlbumInfo.name)
    }
    
    func test_artist() {
        XCTAssertEqual(viewModel?.artist, mockAlbumInfo.artist)
    }
    
    func test_imageUrl() {
        if let imageString = mockAlbumInfo.albumImage, let url = URL(string: imageString) {
            XCTAssertEqual(url, viewModel?.albumImageUrl)
        } else {
            XCTFail()
        }
    }
}
