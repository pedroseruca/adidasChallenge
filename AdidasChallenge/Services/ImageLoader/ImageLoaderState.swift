//
//  ImageLoaderState.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import UIKit

enum ImageLoaderState: Equatable {
    case initial
    case loading
    case success(UIImage)
    case failure(Error)

    static func == (lhs: ImageLoaderState, rhs: ImageLoaderState) -> Bool {
        switch (lhs, rhs) {
        case (initial, initial),
             (loading, loading),
             (success, success),
             (failure, failure):
            return true

        default:
            return false
        }
    }
}
