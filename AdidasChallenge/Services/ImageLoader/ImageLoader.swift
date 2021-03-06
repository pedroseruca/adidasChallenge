//
//  ImageLoader.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import Combine
import UIKit
import os

protocol ImageLoaderProtocol {
    var statePublisher: Published<ImageLoaderState>.Publisher { get }
    func load(with imageWidth: Int?)
}

class ImageLoader: ImageLoaderProtocol {
    // MARK: Private Properties

    @Published private var state: ImageLoaderState = .initial
    private let urlString: String
    private var cache: ImageCacheProtocol?
    private var cancellable: AnyCancellable?

    // MARK: Lifecycle

    init(for urlString: String, cache: ImageCacheProtocol? = nil) {
        self.urlString = urlString
        self.cache = cache
    }

    // MARK: Public Properties

    var statePublisher: Published<ImageLoaderState>.Publisher { $state }

    // MARK: Public Methods

    func load(with imageWidth: Int?) {
        if state != .initial { return }
        guard let url = transformUrl(with: imageWidth) else {
            state = .failure(ImageLoaderError.urlNotValid)
            
            let text: StaticString = "transformUrl method couldn't transform image url for needed size. Original url: %@. Size width requested: %@"
            let imageWidth = imageWidth != nil ? String(describing: imageWidth) : "none"
            os_log(text, type: .error, urlString, imageWidth)
            return
        }
        
        if let image = cache?[url.absoluteString] {
            state = .success(image)
            return
        }
        
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
                    self?.cache?[url.absoluteString] = image
                } else {
                    self?.state = .failure(ImageLoaderError.couldntTransformData)
                }
            })
    }

    // MARK: Private Methods

    private func transformUrl(with imageWidth: Int?) -> URL? {
        guard let imageWidth = imageWidth else { return URL(string: urlString) }
        let urlString = replaceSize(on: urlString,
                                    with: imageWidth)
        return URL(string: urlString)
    }

    private func replaceSize(on urlString: String, with size: Int) -> String {
        var copy = urlString
        ["w_", "h_"].forEach { measure in
            replace(measure: measure, with: size)
        }

        func replace(measure: String, with size: Int) {
            if let range = copy.range(of: measure) {
                let lowerRange = copy.index(before: copy.index(after: range.lowerBound))
                let range = lowerRange ..< copy.endIndex

                if let upperRange = copy.range(of: ",", range: range)?.lowerBound {
                    copy.replaceSubrange(lowerRange ..< upperRange, with: measure + "\(size)")
                }
            }
        }

        return copy
    }
}
