//
//  MockBadAlbumLoader.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation
@testable import Apple_Music

class MockBadAlbumLoader: MockJSONLoader {
    override func getAlbums(_ url: URL, completion: @escaping NetworkHandler) {
        let albums = [MockExpectations.badAlbum,
                      MockExpectations.badAlbum]
        let feed = Feed(title: "Mock", id: "1",
                        author: nil, links: nil,
                        copyright: nil, country: nil,
                        icon: nil, updated: nil,
                        results: albums)
        let result = AppleMusicAlbums(feed: feed)
        completion(.success(result))
    }
}
