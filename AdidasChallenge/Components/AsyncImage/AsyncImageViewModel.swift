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

    @Published private(set) var state: ImageLoaderState = .initial
    private var cancellable: AnyCancellable?

    init(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader

        cancellable =
            imageLoader
                .statePublisher
                .receive(on: RunLoop.main)
                .sink { [weak self] state in
                    self?.state = state
                }
    }

    func load() {
        imageLoader.load()
    }
}
