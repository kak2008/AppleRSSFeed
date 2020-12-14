//
//  AlbumDetailViewModelTests.swift
//  AppleRSSfeedTests
//
//  Created by Anish on 12/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import XCTest
@testable import AppleRSSfeed

class AlbumDetailViewModelTests: XCTestCase {

    var viewModel: AlbumDetailViewModel?
    
    override func setUp() {
        super.setUp()
        
        viewModel = AlbumDetailViewModel(album: mockAlbum())
    }
    
    func test_title() {
        XCTAssertEqual(viewModel?.title, "Album")
    }
    
    func test_name() {
        XCTAssertEqual(viewModel?.name , mockAlbum().name)
    }
    
    func test_artistName() {
        XCTAssertEqual(viewModel?.artistName, mockAlbum().artistName)
    }
    
    func test_releaseDate() {
        XCTAssertEqual(viewModel?.releaseDate, mockAlbum().releaseDate)
    }
    
    func test_copyRight() {
        XCTAssertEqual(viewModel?.copyRight, mockAlbum().copyright)
    }
    
    func test_genreLabel() {
        XCTAssertEqual(viewModel?.genreLabel, mockAlbum().genres.first?.name)
    }
    
    func test_websiteTitle() {
        XCTAssertEqual(viewModel?.websiteViewControllerTitle, "Apple Music")
    }
    
    func test_albumUrl() {
        if let url = URL(string: mockAlbum().artworkUrl100) {
            XCTAssertEqual(viewModel?.albumUrl, url)
        } else {
            XCTFail()
        }
    }
    
    func test_albumWebsiteUrl() {
        if let url = URL(string: mockAlbum().url) {
            XCTAssertEqual(viewModel?.albumWebsiteUrl, url)
        } else {
            XCTFail()
        }
    }
    
    func test_genreLabelConcatenation() {
        // Scenario 1
        let genreLabel = viewModel?.genreLabel(mockAlbum().genres)
        XCTAssertEqual(genreLabel, "mock genere hip")
        
        // Scenario 2
        let genre2 = Genre(genreId: "133", name: "Rock", url: "www.abcd.com")
        let genre3 = Genre(genreId: "123", name: "Tip top", url: "www.abcd.com")
        let genres = [genre2, genre3]
        let genreConstructedLabel = viewModel?.genreLabel(genres)
        XCTAssertEqual(genreConstructedLabel, "Rock | Tip top")
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
}
