//
//  NetworkHandler.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

typealias NetworkHandler = (_ result: Result<AppleMusicAlbums, ErrorInfo>) -> Void

// Error type 
struct ErrorInfo: Error {
    var errorDescription: String?
}

protocol NetworkService: class {
    func getAlbums(_ url: URL, completion: @escaping NetworkHandler)
}

class NetworkConnection: NetworkService {
    func getAlbums(_ url: URL, completion: @escaping NetworkHandler) {
        URLSession.shared.dataTask(with: url) { (dat,_, err) in
            if let error = err {
                completion(.failure(.init(errorDescription: error.localizedDescription)))
                return
            }
            
            if let data = dat {
                do {
                    let results = try JSONDecoder().decode(AppleMusicAlbums.self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.init(errorDescription: error.localizedDescription)))
                    return
                }
            }
        }.resume()
    }
}


