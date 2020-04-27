//
//  AlbumInfoViewModelTests.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import XCTest
@testable import Apple_Music

class AlbumInfoViewModelTests: XCTestCase {
    
    let mockLoader = MockJSONLoader()
    let mockModel = MockExpectations.album
    lazy var mockAlbum: Album = {
        let result = mockLoader.load(Album.self, .album)
        guard case Result.success(let album) = result else {
            fatalError()
        }
        return album
    }()
    
    func testAlbumInfoViewModel() {
        // Given
        let albumInfoViewModel = AlbumInfoViewModel(mockAlbum)
        
        // Then
        XCTAssertEqual(albumInfoViewModel.artistName,
                       mockModel.artistName)
        XCTAssertEqual(albumInfoViewModel.albumName,
                       mockModel.name)
        XCTAssertEqual(albumInfoViewModel.genre,
                       mockModel.genres?.compactMap { $0.name }.joined(separator: " "))
        XCTAssertEqual(albumInfoViewModel.releaseDate,
                       mockModel.releaseDate)
        XCTAssertEqual(albumInfoViewModel.copyrightInfo,
                       mockModel.copyright)
        XCTAssertEqual(albumInfoViewModel.linkoutUrl?.absoluteString,
                       mockModel.url)
    }
    
    func testAlbumInfoViewModelWithBadAlbum() {
        // Given
        let albumInfoViewModel = AlbumInfoViewModel(mockAlbum)
        
        // When
        var data: Data?
        albumInfoViewModel.getArtworkImage { dataResponse in
            data = dataResponse
        }
        
        // Then
        XCTAssertNotNil(data)
        XCTAssertEqual(albumInfoViewModel.artistName,
                       mockModel.artistName)
        XCTAssertEqual(albumInfoViewModel.albumName,
                       mockModel.name)
        XCTAssertEqual(albumInfoViewModel.genre,
                       mockModel.genres?.compactMap { $0.name }.joined(separator: " "))
        XCTAssertEqual(albumInfoViewModel.releaseDate,
                       mockModel.releaseDate)
        XCTAssertEqual(albumInfoViewModel.copyrightInfo,
                       mockModel.copyright)
        XCTAssertEqual(albumInfoViewModel.linkoutUrl?.absoluteString,
                       mockModel.url)
    }
    
}
