//
//  AlbumsViewModelTests.swift
//  AppleRSSfeedTests
//
//  Created by Anish on 12/10/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import XCTest
@testable import AppleRSSfeed

class AlbumsViewModelTests: XCTestCase {

    var albumsViewModel: AlbumsViewModel?
    
    override func setUp() {
        super.setUp()
        
        albumsViewModel = AlbumsViewModel()
    }
    
    func test_ViewTitle() {
        XCTAssertEqual(albumsViewModel?.viewTitle, "Albums")
    }

}
