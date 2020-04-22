//
//  AlbumViewModel.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class AlbumViewModel {
  
    private let service: NetworkService
    private let imageService = ImageService()
    var updateView: (() -> Void)?
    private var albums = [Album]() {
        didSet {
            self.updateView?()
        }
    }
    
    init(service: NetworkService = NetworkConnection()) {
        self.service = service
    }
 
    func downloadAlbum(_ url: URL) {
        service.getAlbums(url ){ result in
            switch result {
            case .success(let responseAlbums):
                self.albums = responseAlbums.feed?.results ?? []
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var numberOfAlbums: Int {
        return albums.count
    }
    
    func getAlbumName (_ index: Int) -> String {
        return albums[index].name ?? "No album name"
    }
    
    func getArtistName(_ index: Int) -> String {
        return albums[index].artistName ?? "No artirst name"
    }
    
    func getArtworkImage(_ index: Int, _ completion: @escaping (Data?) -> Void) {
        guard let imageLink = albums[index].artworkUrl100,
            let url = URL(string: imageLink) else {
                completion(nil)
                return
        }
        imageService.download(url: url, completion)
    }
    
    func infoAlbumViewModel(for index: Int) -> AlbumInfoViewModel {
        let viewModel = AlbumInfoViewModel(albums[index], imageService: imageService)
        return viewModel
    }
    
    
}
