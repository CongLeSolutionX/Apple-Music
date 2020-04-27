//
//  ImagePersister.swift
//  Apple-Music
//
//  Created by Cong Le on 4/24/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation

// djbHash algorithm makes image name unique
extension URL {
    var djbHash: Int {
        return self.absoluteString.utf8
            .map {return $0}
            .reduce(5381) {
                ($0 << 5) &+ $0 &+ Int($1)
        }
    }
    
    var djbHashString: String {
        String(djbHash)
    }
}

class ImagePersister {
    
    private let cache = NSCache<NSString, NSData>()
    private let fileManager = FileManager.default
    private let rootUrl: URL
        
    init() {
        guard let url = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("Error - could not access filesystem")
        }
        rootUrl = url
    }
    
}
// set, save, get, and load persistent data on the disk 
extension ImagePersister {
    
    // MARK: - Data Accessors
    
    func set(_ data: Data, forKey key: String) {
        let nsData = NSData(data: data)
        let nsString = NSString(string: key)
        cache.setObject(nsData, forKey: nsString)
        self.save(data, forKey: key)
    }
    
    func get(forKey key: String) -> Data? {
        let nsString = NSString(string: key)
        if let data = cache.object(forKey: nsString) {
            return Data(referencing: data)
        }
        else if let diskData = load(forKey: key) {
            let nsData = NSData(data: diskData)
            cache.setObject(nsData, forKey: nsString)
            return diskData
        }
        return nil
    }
    
    // MARK: - Disk Accessors
    private func load(forKey key: String) -> Data? {
        let url = rootUrl.appendingPathComponent(key)
        return try? Data(contentsOf: url)
    }
    
    private func save(_ data: Data, forKey key: String) {
        let url = rootUrl.appendingPathComponent(key)
        try? data.write(to: url)
    }
    
}
