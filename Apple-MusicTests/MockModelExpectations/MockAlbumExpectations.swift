//
//  MockAlbumExpectations.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation
@testable import Apple_Music

enum MockExpectations {
    static let album = Album(artistName: "DaBaby",
                             id: "1508023035",
                             releaseDate: "2020-04-17",
                             name: "BLAME IT ON BABY",
                             kind: .album,
                             copyright: "South Coast Music Group/Interscope Records; ℗ 2020 Interscope Records",
                             artistID: "1175595427",
                             contentAdvisoryRating: .explicit,
                             artistURL: "https://music.apple.com/us/artist/dababy/1175595427?app=music",
                             artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Music123/v4/cc/c2/34/ccc23410-3166-90b6-cc40-8a7698ae1a90/20UMGIM28169.rgb.jpg/200x200bb.png",
                             genres: [.init(genreID: "18", name: "Hip-Hop/Rap", url: "https://itunes.apple.com/us/genre/id18"),
                                      .init(genreID: "34", name: "Music", url: "https://itunes.apple.com/us/genre/id34")],
                             url: "https://music.apple.com/us/album/blame-it-on-baby/1508023035?app=music")
    
    static let badAlbum = Album(artistName: nil,
                                id: nil,
                                releaseDate: nil,
                                name: nil,
                                kind: nil,
                                copyright: nil,
                                artistID: nil,
                                contentAdvisoryRating: nil,
                                artistURL: nil,
                                artworkUrl100: "com.mock",
                                genres: nil,
                                url: "com.mock")
}
