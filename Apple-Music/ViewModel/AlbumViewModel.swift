//
//  AlbumViewModel.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class AlbumViewModel {
  // MARK: - Properties
  private let service: NetworkService
  private let imageService = ImageService()
  var updateView: (() -> Void)?
  private var albums = [Album]() {
    didSet {
      self.updateView?()
    }
  }
  
  var numberOfAlbums: Int {
    return albums.count
  }
  
  // Injecting depedencies from objects (NetworkConnection and ImageServiceProvider) at initilizing
  init(service: NetworkService = NetworkHandler(), imageService: ImageServiceProvider = ImageService()) {
    self.service = service
  }
  // MARK: - Methods
  func downloadAlbum(_ albumUrl: URL) {
    service.getAlbums(albumUrl) { result in
      switch result {
      case .success(let responseAlbums):
        self.albums = responseAlbums.feed?.results ?? []
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  func getAlbumName (_ index: Int) -> String {
    return albums[index].name ?? "No album name"
  }
  
  func getArtistName(_ index: Int) -> String {
    return albums[index].artistName ?? "No artist name"
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
