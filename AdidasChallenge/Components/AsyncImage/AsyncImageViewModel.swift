//
//  AsyncImageViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import Combine
import SwiftUI

class AsyncImageViewModel: ObservableObject {
    // MARK: Private Properties

    private var imageLoader: ImageLoaderProtocol
    private var imageWidth: Int?

    private var cancellable: AnyCancellable?

    // MARK: Lifecycle

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

    // MARK: Public Properties

    @Published private(set) var state: ImageLoaderState = .initial

    // MARK: Public Methods

    func load() {
        imageLoader.load(with: imageWidth)
    }
}
