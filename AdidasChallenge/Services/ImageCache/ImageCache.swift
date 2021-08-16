//
//  ImageCache.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 16/08/2021.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    subscript(_ key: String) -> UIImage? { get set }
}

class ImageCache: ImageCacheProtocol {
    private let cache = NSCache<NSString, UIImage>()
    
    subscript(_ key: String) -> UIImage? {
        get {
            let nsString = NSString(string: key)
            return cache.object(forKey: nsString)
        }
        set {
            guard let newValue = newValue else { return }
            cache.setObject(newValue,
                            forKey: NSString(string: key))
        }
    }
}
