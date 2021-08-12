//
//  AsyncImageViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import Combine
import SwiftUI

class AsyncImageViewModel: ObservableObject {
    private var imageLoader: ImageLoaderProtocol
    private var imageWidth: Int?

    @Published private(set) var state: ImageLoaderState = .initial
    private var cancellable: AnyCancellable?

    init(imageLoader: ImageLoaderProtocol,
         imageWidth: Int? = nil) {
        self.imageLoader = imageLoader
        self.imageWidth = imageWidth

        cancellable =
            imageLoader
                .statePublisher
                .receive(on: RunLoop.main)
                .sink { [weak self] state in
                    self?.state = state
                }
    }

    func load() {
        imageLoader.load(with: imageWidth)
    }
}
