//
//  NetworkHandler.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

typealias NetworkResponseHandler = (_ result: Result<AppleMusicAlbums, ServerErrors>) -> Void

struct ServerErrors: Error {
  var errorDescription: String?
}

protocol NetworkService: class {
  func getAlbums(_ url: URL, completion: @escaping NetworkResponseHandler)
}

/// Download albums from Apple API and save the data into model layer 
class NetworkHandler: NSObject, NetworkService {
  
  func getAlbums(_ albumUrl: URL, completion: @escaping NetworkResponseHandler) {
    let config = URLSessionConfiguration.default
    // only fire request when device is connected to the Internet with defined time interval
    config.waitsForConnectivity = true
    config.timeoutIntervalForResource = 300
    
    // Handle connectivity updates via URLSessionDelegate and update on the main thread
    let session = URLSession(configuration: config, delegate: NetworkHandler(), delegateQueue: .main)
    // Create a task that perform downloading
    let task = session.dataTask(with: albumUrl) { (dataReceived, response, serverError) in
      // Handle server error
      if let error = serverError {
        completion(.failure(.init(errorDescription: error.localizedDescription)))
        return
      }
      
      // Unwrap the HTTPS response code
      if let httpResponse = response as? HTTPURLResponse {
        // Check valid response codes
        if (200...299).contains(httpResponse.statusCode) {
          // Check MIME type of the response and we expecting JSON data
          guard let mime = httpResponse.mimeType, mime == "application/json" else {
            assertionFailure("Wrong mime type!")
            return
          }
          
          // Create a background queue to handle all the downloading
          DispatchQueue.global(qos: .background).async {
            if let data = dataReceived {
              do {
                let results = try JSONDecoder().decode(AppleMusicAlbums.self, from: data)
                completion(.success(results))
              } catch {
                completion(.failure(.init(errorDescription: error.localizedDescription)))
                return
              }
            }
          }
        }
        else {
          assertionFailure("\(httpResponse.value(forHTTPHeaderField: "Status") ?? "No valid status")")
          completion(.failure(.init()))
          return
        }
      }
    }
    // Starts the data task via resume() because all tasks start in a suspended state by default
    task.resume()
  }
}

// MARK: - URLSessionDelegate
extension NetworkHandler: URLSessionDelegate {
  func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
    // Indicate network status, e.g., offline mode
  }
  
  func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest: URLRequest, completionHandler: (URLSession.DelayedRequestDisposition, URLRequest?) -> Void) {
    // Indicate network status, e.g., back to online
  }
}
