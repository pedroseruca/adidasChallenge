//
//  ImageLoader.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import Combine
import UIKit

enum ImageLoaderError: Error {
    case urlNotValid
    case couldntTransformData
}

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

protocol ImageLoaderProtocol: ObservableObject {
    var state: ImageLoaderState { get }
    func load()
}

class ImageLoader: ImageLoaderProtocol {    
    @Published var state: ImageLoaderState = .initial

    private let url: URL?
    private var cancellable: AnyCancellable?

    init(for url: URL?) {
        self.url = url
    }

    func load() {
        if state != .initial { return }
        guard let url = url else {
            state = .failure(ImageLoaderError.urlNotValid)
            return
        }
        
        // TODO: check cache before start request
        state = .loading
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] error in
                switch error {
                case let .failure(error):
                    self?.state = .failure(error)
                default:
                    break
                }
                print(error)
            }, receiveValue: { [weak self] image in
                if let image = image {
                    self?.state = .success(image)
                } else {
                    self?.state = .failure(ImageLoaderError.couldntTransformData)
                }
            })
    }
}
