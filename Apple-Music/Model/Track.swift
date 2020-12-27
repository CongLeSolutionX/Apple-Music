//
//  Track.swift
//  Apple-Music
//
//  Created by Cong Le on 12/26/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

class Track {
  
  let artist: String
  let index: Int
  let name: String
  let previewURL: URL
  
  var downloaded = false
  
  init(name: String, artist: String, previewURL: URL, index: Int) {
    self.name = name
    self.artist = artist
    self.previewURL = previewURL
    self.index = index
  }
}
