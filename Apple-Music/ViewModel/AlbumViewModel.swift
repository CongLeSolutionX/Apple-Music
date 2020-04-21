//
//  AlbumViewModel.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit



class AlbumViewModel {
  
    var service: NetworkService
    // initilizer DI
    init(service: NetworkService = NetworkConnection() ) {
        self.service = service
    }
    var updateView: (() -> Void)?
    var albums = AppleMusicAlbums() {
        didSet {
            self.updateView?()
        }
    }
 
    func downloadAlbum(_ url: URL) {
        service.getAlbums(url ){ result in
            switch result {
                
            case .success(let responseAlbums):
                
               self.albums = responseAlbums
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNumberOfAlbums() -> Int {
        return albums.feed?.results?.count ?? 0
    }
    
    func getAlbumName (_ index: Int) -> String {
        return albums.feed?.results?[index].name ?? "No album name"
    }
    
    func getArtistName(_ index: Int) -> String {
        return albums.feed?.results?[index].artistName ?? "No artirst name"
    }
    
    func getArkworkImage(_ index: Int) -> URL? {
     
        guard let imageLink = albums.feed?.results?[index].artworkUrl100 else {
           return nil
        }
        return URL(string: imageLink)
    }
    
    func infoAlbumViewModel( for index: Int, completionHandler: @escaping (AlbumInfoViewModel?) -> Void) {
       // service.getAlbums(albums.feed?.results?[index]) { result in
            
            
            
        //}
    }
    
    
}
