//
//  AlbumViewModelTests.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import XCTest
@testable import Apple_Music

class AlbumViewModelTests: XCTestCase {
    
    let mockLoader = MockJSONLoader()
    let badLoader = MockBadAlbumLoader()
    let nilLoader = MockNilLoader()
    let dataLoader = MockDataLoader()
    
    func testAlbumViewModelCanDownload() {
        // Given
        let albumViewModel = AlbumViewModel(service: mockLoader)
        
        // When
        albumViewModel.downloadAlbum(URL(fileURLWithPath: "com.test"))
        let infoAlbumViewModel = albumViewModel.infoAlbumViewModel(for: 0)
        
        // Then
        XCTAssertEqual(albumViewModel.numberOfAlbums, 10)
        XCTAssertNotEqual(albumViewModel.getAlbumName(0), "No album name")
        XCTAssertNotEqual(albumViewModel.getArtistName(0), "No artist name")
        XCTAssertNotNil(infoAlbumViewModel.albumName)
    }
    
    func testAlbumViewModelCanGetImage() {
        // Given
        let albumViewModel = AlbumViewModel(service: mockLoader)
        
        // When
        var data: Data?
        albumViewModel.downloadAlbum(URL(fileURLWithPath: "com.test"))
        albumViewModel.getArtworkImage(0) { (dataResult) in
            data = dataResult
        }
        
        // Then
        XCTAssertNotNil(data)
    }
    
    func testAlbumViewModelCanFailToGetImage() {
        // Given
        let albumViewModel = AlbumViewModel(service: mockLoader,
                                            imageService: dataLoader)
        
        // When
        var data: Data?
        albumViewModel.downloadAlbum(URL(fileURLWithPath: "com.test"))
        albumViewModel.getArtworkImage(0) { (dataResult) in
            data = dataResult
        }
        
        // Then
        XCTAssertNotNil(data)
    }
    
    func testAlbumViewModelCanCallback() {
        // Given
        let albumViewModel = AlbumViewModel(service: mockLoader)
        var didCallback = false
        albumViewModel.updateView = {
            didCallback = true
        }
        
        // When
        albumViewModel.downloadAlbum(URL(fileURLWithPath: "com.test"))
        
        // Then
        XCTAssertTrue(didCallback)
    }
    
    func testAlbumViewModelWithBadAlbums() {
        // Given
        let albumViewModel = AlbumViewModel(service: badLoader)
        
        // When
        var data: Data? = Data()
        albumViewModel.downloadAlbum(URL(fileURLWithPath: "com.test"))
        albumViewModel.getArtworkImage(0) { (dataResult) in
            data = dataResult
        }
        
        // Then
        XCTAssertNil(data)
        XCTAssertEqual(albumViewModel.getAlbumName(0), "No album name")
        XCTAssertEqual(albumViewModel.getArtistName(0), "No artist name")
    }
    
    func testAlbumViewModelWithFailedLoad() {
        // Given
        let albumViewModel = AlbumViewModel(service: nilLoader)
        var didCallback = false
        albumViewModel.updateView = {
            didCallback = true
        }
        
        // When
        albumViewModel.downloadAlbum(URL(fileURLWithPath: "com.test"))
        
        // Then
        XCTAssertFalse(didCallback)
        XCTAssertEqual(albumViewModel.numberOfAlbums, 0)
    }
    
}
