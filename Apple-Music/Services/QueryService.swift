//
//  QueryService.swift
//  Apple-Music
//
//  Created by Cong Le on 12/26/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

class QueryService {
  
  var errorMessage = ""
  var tracks: [Track] = []
  
  
  typealias JSONDictionary = [String: Any]
  typealias QueryResult = ([Track]?, String) -> Void
  
  
  func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
    DispatchQueue.main.async {
      completion(self.tracks, self.errorMessage)
    }
  }
}

// MARK: - Private Methods 
extension QueryService {
  private func updateSearchResults(_ data: Data) {
    var response: JSONDictionary?
    tracks.removeAll()
    
    do {
      response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    } catch let parseError as NSError {
      errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
      return
    }
    
    guard let array = response!["results"] as? [Any] else {
      errorMessage += "Dictionary does not contain results key\n"
      return
    }
    
    var index = 0
    
    for trackDictionary in array {
      if let trackDictionary = trackDictionary as? JSONDictionary,
        let previewURLString = trackDictionary["previewUrl"] as? String,
        let previewURL = URL(string: previewURLString),
        let name = trackDictionary["trackName"] as? String,
        let artist = trackDictionary["artistName"] as? String {
          tracks.append(Track(name: name, artist: artist, previewURL: previewURL, index: index))
          index += 1
      } else {
        errorMessage += "Problem parsing trackDictionary\n"
      }
    }
  }
}
