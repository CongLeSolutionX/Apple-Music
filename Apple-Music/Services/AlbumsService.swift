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
// Download albums from Apple API and save the data into model layer 
class NetworkConnection: NetworkService {
    func getAlbums(_ url: URL, completion: @escaping NetworkHandler) {
        URLSession.shared.dataTask(with: url) { (dat, response, err) in
            // Error handling
            if let error = err {
                completion(.failure(.init(errorDescription: error.localizedDescription)))
                return
            }
            // unwrap the HTTPS response code
            if let httpResponse = response as? HTTPURLResponse {
                // if we receive a valid response code,
                if  (200...299).contains(httpResponse.statusCode) {
                    print("Valid HTTPS status code is below")
                    print(httpResponse.value(forHTTPHeaderField: "Status") ?? "No Valid Status")
                    // then, get the data from the server
                    if let data = dat {
                        do {
                            let results = try JSONDecoder().decode(AppleMusicAlbums.self, from: data)
                            completion(.success(results))
                        } catch {
                            completion(.failure(.init(errorDescription: error.localizedDescription)))
                            return
                        }
                    }
                }
                else {
                    print("error with the server with the following status:")
                    print(httpResponse.value(forHTTPHeaderField: "Status") ?? "No Valid Status")
                    completion(.failure(.init()))
                    return
                }
            }
        }.resume()
    }
}


