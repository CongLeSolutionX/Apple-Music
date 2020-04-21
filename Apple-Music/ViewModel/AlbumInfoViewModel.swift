//
//  AlbumInfoViewModel.swift
//  Apple-Music
//
//  Created by Cong Le on 4/21/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

class AlbumInfoViewModel {
    private let albumInfo: Album
    
    init(_ albumInfo: Album) {
        self.albumInfo = albumInfo
    }
    
    var arkworkLink: URL? {
        guard let url = albumInfo.artworkUrl100 else {
            return nil
        }
        return URL(string: url)
    }
    
    var artistName: String? {
        return albumInfo.artistName
    }
    
    var albumName: String? {
        return albumInfo.name
    }
    
}
