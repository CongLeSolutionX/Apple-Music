//
//  MockDataLoader.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation
@testable import Apple_Music

class MockDataLoader { }

extension MockDataLoader: ImageServiceProvider {
    func download(url: URL, _ completion: @escaping (Data?) -> Void) {
        completion(Data())
    }
}
