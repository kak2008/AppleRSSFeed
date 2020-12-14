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
    var mockAlbumsViewController: MockAlbumsViewController?
    var mockNetworkCommunicator: MockNetworkCommunicator?
    
    override func setUp() {
        super.setUp()
        mockAlbumsViewController = MockAlbumsViewController()
        mockNetworkCommunicator = MockNetworkCommunicator()
        
        guard let mockAlbumVC = mockAlbumsViewController,
            let mockNetworkVC = mockNetworkCommunicator else { return }
        
        albumsViewModel = AlbumsViewModel(delegate: mockAlbumVC,
                                          networkCommunicator: mockNetworkVC)
    }
    
    func test_ViewTitle() {
        XCTAssertEqual(albumsViewModel?.viewTitle, "Albums")
    }

    func test_numberOfRows() {
        let album = mockAlbum()
        albumsViewModel?.albums = [album]
        XCTAssertEqual(albumsViewModel?.numberOfRows, 1)
    }
    
    func test_getAlbumsData() {
        albumsViewModel?.getAlbumsData()
        XCTAssertTrue(mockAlbumsViewController?.isDelegateMethodCalled ?? false)
    }
    
    func test_cellViewModel() {
        albumsViewModel?.albums = [mockAlbum()]
        
        let indexpath = IndexPath(row: 0, section: 0)
        if let cellViewModel = albumsViewModel?.cellViewModel(for: indexpath) {
            XCTAssertEqual(cellViewModel.name, mockAlbum().name)
            XCTAssertEqual(cellViewModel.artist, mockAlbum().artistName)
        } else {
            XCTFail()
        }
    }
}

class MockAlbumsViewController: AlbumsViewController {
    var isDelegateMethodCalled = false
    
    override func albumsDataRetrieved() {
        isDelegateMethodCalled = true
    }
}

class MockNetworkCommunicator: NetworkCommunicator {
    
    override func getAlbumsData(completion: @escaping ([Album]?, Error?) -> Void) {
        completion([mockAlbum()], nil)
    }
    
}

// MARK:- Mock Data

func mockAlbum() -> Album {
    
    let genres = Genre(genreId: "123", name: "mock genere hip", url: "www.google.com/hip")
    let album = Album(artistName: "art mock name",
                      id: "art mock id",
                      releaseDate: "mock release dta",
                      name: "mock name",
                      kind: "mock kind",
                      copyright: "copyright mock",
                      artistId: "123y mock",
                      artistUrl: "http://google.com mock",
                      artworkUrl100: "http://google.com/home",
                      url: "http://fb.com/home",
                      genres: [genres])
    
    return album
}
