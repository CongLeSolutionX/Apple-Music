//
//  Album.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

// MARK: - AppleMusicAlbums
struct AppleMusicAlbums: Codable {
    var feed: Feed?
}

// MARK: - Feed
struct Feed: Codable {
    var title: String?
    var id: String?
    var author: Author?
    var links: [Link]?
    var copyright, country: String?
    var icon: String?
    var updated: String?
    var results: [Album]?
}

// MARK: - Author
struct Author: Codable {
    var name: String?
    var uri: String?
}

// MARK: - Link
struct Link: Codable {
    var linkSelf: String?
    var alternate: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf
        case alternate
    }
}

// MARK: - Result aka Albums
struct Album: Codable {
    var artistName, id, releaseDate, name: String?
    var kind: Kind?
    var copyright, artistID: String?
    var contentAdvisoryRating: ContentAdvisoryRating?
    var artistURL: String?
    var artworkUrl100: String?
    var genres: [Genre]?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case artistName, id, releaseDate, name, kind, copyright
        case artistID
        case contentAdvisoryRating
        case artistURL
        case artworkUrl100, genres, url
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explicit = "Explicit"
}

// MARK: - Genre
struct Genre: Codable {
    var genreID, name: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case genreID
        case name, url
    }
}

enum Kind: String, Codable {
    case album = "album"
}


//// MARK: - Genre
//struct AppleMusicAlbum: Codable {
//    let results: [Album]
//}
//
//struct Album: Codable {
//    let albumName: String
//    let artist: String
//    let artwork: String
//    // cutomizing the name convention for codable, object must conform with Codingkey protocol
//    private enum CodingKeys: String, CodingKey {
//        case albumName = "name"
//        case artist = "artistName"
//        case artwork = "artworkUrl100"
//    }
//}

