//
//  AlbumInfoViewModel.swift
//  Apple-Music
//
//  Created by Cong Le on 4/21/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

class AlbumInfoViewModel {
    
    private var albumInfo: Album {
        didSet {
            updateView?()
        }
    }
    private let imageService: ImageService
    var updateView: (() -> Void)?
    
    init(_ albumInfo: Album, imageService: ImageService = ImageService()) {
        self.albumInfo = albumInfo
        self.imageService = imageService
    }
    
    var artworkLink: URL? {
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
    
    func getArtworkImage(_ completion: @escaping (Data?) -> Void) {
        guard let imageLink = albumInfo.artworkUrl100,
            let url = URL(string: imageLink) else {
                completion(nil)
                return
        }
        imageService.download(url: url, completion)
    }
    
    var genre: String? {
        return albumInfo.genres?.compactMap { $0.name }.joined(separator: " ")
    }
    
    var releaseDate: String? {
        return albumInfo.releaseDate
    }
    
    var copyrightInfo: String? {
        return albumInfo.copyright
    }
    
    var linkoutUrl: URL? {
        guard let urlString = albumInfo.url else {
            return nil
        }
        return URL(string: urlString)
    }
    
}
