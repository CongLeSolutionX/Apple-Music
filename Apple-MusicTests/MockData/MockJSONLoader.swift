//
//  MockJSONLoader.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation
@testable import Apple_Music

class MockJSONLoader: NetworkService {
    
    let decoder: JSONDecoder
    
    init(_ decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func load<T: Decodable>(_ type: T.Type, _ option: MockJSONOptions) -> Result<T, Error> {
        Result(catching: { try decoder.decode(type, from: option.data) })
    }
    
    func getAlbums(_ url: URL, completion: @escaping NetworkHandler) {
        let result = load(AppleMusicAlbums.self, .albums)
        guard case Result.success(let albumResult) = result else {
                fatalError()
        }
        completion(.success(albumResult))
    }
}
