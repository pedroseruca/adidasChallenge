//
//  ImageLoader.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import Combine
import UIKit

protocol ImageLoaderProtocol {
    var statePublisher: Published<ImageLoaderState>.Publisher { get }
    func load(with imageWidth: Int?)
}

class ImageLoader: ImageLoaderProtocol {
    var statePublisher: Published<ImageLoaderState>.Publisher { $state }

    @Published private var state: ImageLoaderState = .initial
    private let urlString: String
    private var cancellable: AnyCancellable?

    init(for urlString: String) {
        self.urlString = urlString
    }

    func load(with imageWidth: Int?) {
        if state != .initial { return }
        guard let url = makeUrl(for: imageWidth) else {
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

    private func makeUrl(for imageWidth: Int?) -> URL? {
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
