//
//  AlbumTests.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import XCTest
@testable import Apple_Music

class AlbumTests: XCTestCase {
    
    func testCanMakeAlbum() {
        // Given
        let loader = MockJSONLoader()
        
        // When
        let result = loader.load(Album.self, .album)
        var album: Album?
        switch result {
            case .success(let albumResult):
                album = albumResult
            case .failure(let error):
                XCTFail(error.localizedDescription)
        }
        
        // Then
        XCTAssertNotNil(album)
    }
    
    func testCanMakeAlbums() {
        // Given
        let loader = MockJSONLoader()
        
        // When
        let result = loader.load(AppleMusicAlbums.self, .albums)
        var albums: [Album] = []
        switch result {
            case .success(let results):
                albums = results.feed?.results ?? []
            case .failure(let error):
                XCTFail(error.localizedDescription)
        }
        
        // Then
        XCTAssertTrue(!albums.isEmpty)
        XCTAssertEqual(albums.count, 10)
    }
    
}
