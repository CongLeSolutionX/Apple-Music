//
//  MockNilLoader.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation
@testable import Apple_Music

class MockNilLoader: MockJSONLoader {
    override func getAlbums(_ url: URL, completion: @escaping NetworkHandler) {
        completion(.failure(.init(errorDescription: "Bad")))
    }
}
