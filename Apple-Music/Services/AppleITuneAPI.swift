//
//  URLHandler.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

// Construct the URL for JSON request 
struct AppleITuneAPI {
  
  // https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json
  
  static let base = "https://rss.itunes.apple.com/api/v1/"
  static let topAlbums = "/us/apple-music/top-albums/all/100/explicit.json"
  
  
  static func getAlbumURL() -> URL? {
    return URL(string: base + topAlbums)
  }
}
