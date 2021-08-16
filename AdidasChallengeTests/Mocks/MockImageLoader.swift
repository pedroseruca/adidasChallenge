//
//  MockImageLoader.swift
//  AdidasChallengeTests
//
//  Created by Pedro Seruca on 16/08/2021.
//

import Foundation
import SwiftUI
@testable import AdidasChallenge

class MockImageLoader: ImageLoaderProtocol {
    var statePublisher: Published<ImageLoaderState>.Publisher { $state }
    @Published var state: ImageLoaderState = .initial
    
    func load(with imageWidth: Int? = nil) {
        let image = UIImage(named: "Logo")!
        state = .success(image)
    }
    
    
}
