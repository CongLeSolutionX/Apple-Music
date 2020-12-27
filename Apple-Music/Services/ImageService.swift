//
//  ImageService.swift
//  Apple-Music
//
//  Created by Cong Le on 4/19/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

protocol ImageServiceProvider {
  func download(url: URL, _ completion: @escaping (Data?) -> Void )
}
/// Download image from internet using URL
/// Make each image name unique using djbHashString
class ImageService: ImageServiceProvider  {
  
  private let session = URLSession(configuration: .default)
  private var currentDownloads = Set<URL>()
  private var lock = NSLock()
  private let persister = ImagePersister()
  
  func download(url: URL, _ completion: @escaping (Data?) -> Void) {
    let key = url.djbHashString
    if let saved = persister.get(forKey: key) {
      completion(saved)
      return
    }
    if let diskData = persister.get(forKey: key) {
      completion(diskData)
      return
    }
    
    completion(nil)
    if currentDownloads.contains(url) {
      return
    }
    // avoid race condition via using NSLock() to create mutually exclusive lock
    let dataTask = session.dataTask(with: url) { (data, _, _) in
      completion(data)
      self.lock.lock(); defer { self.lock.unlock() }
      if let data = data {
        self.persister.set(data, forKey: key)
      }
      self.currentDownloads.remove(url)
    }
    currentDownloads.insert(url)
    dataTask.resume()
  }
  
}
