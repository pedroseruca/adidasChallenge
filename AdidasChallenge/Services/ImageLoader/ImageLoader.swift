//
//  ImageLoader.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import Combine
import UIKit

enum ImageLoaderError: Error {
    case couldntTransformData
}

enum ImageLoaderState {
    case loading
    case success(UIImage)
    case failure(Error)
}

protocol ImageLoaderProtocol: ObservableObject {
    var state: ImageLoaderState? { get }
    func load()
}

class ImageLoader: ImageLoaderProtocol {    
    @Published var state: ImageLoaderState?

    private let url: URL
    private var cancellable: AnyCancellable?

    init(for url: URL) {
        self.url = url
    }

    func load() {
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
