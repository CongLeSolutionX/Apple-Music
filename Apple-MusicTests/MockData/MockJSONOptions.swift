//
//  MockJSONOptions.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

extension Bundle {
    static let test: Bundle = Bundle(for: MockJSONLoader.self)
}

enum MockJSONOptions: String {
    case albums = "MockAlbumsResponse"
    case album = "MockAlbumResponse"
}

extension MockJSONOptions {
    var path: String {
        guard let path = Bundle.test.path(forResource: self.rawValue, ofType: "json") else {
            fatalError("Error: mock JSON")
        }
        return path
    }
    
    var url: URL {
        URL(fileURLWithPath: path)
    }
    
    var data: NSData {
        guard let data = NSData(contentsOf: self.url) else {
            fatalError("Error: mock JSON")
        }
        return data
    }
    
}
