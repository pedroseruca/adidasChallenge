//
//  AsyncImage.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import Combine
import SwiftUI

struct AsyncImage<Placeholder, ImageView, NoImageView>: View where
    Placeholder: View,
    ImageView: View,
    NoImageView: View {
    // MARK: Private Properties

    @ObservedObject private var viewModel: AsyncImageViewModel
    private let placeholderBuilder: () -> Placeholder
    private let imageBuilder: (UIImage) -> ImageView
    private let errorBuilder: (Error) -> NoImageView

    // MARK: Lifecycle

    init(viewModel: AsyncImageViewModel,
         @ViewBuilder placeholder: @escaping () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> ImageView,
         @ViewBuilder error: @escaping (Error) -> NoImageView) {
        self.viewModel = viewModel
        placeholderBuilder = placeholder
        imageBuilder = image
        errorBuilder = error
    }

    // MARK: Public Properties

    var body: some View {
        Group {
            switch viewModel.state {
            case .initial,
                 .loading:
                placeholderBuilder()
            case let .failure(error):
                errorBuilder(error)
            case let .success(image):
                imageBuilder(image)
            }
        }
        .onAppear { self.viewModel.load() }
    }
}

// MARK: SwiftUI Previews

struct ProductImage_Previews: PreviewProvider {
    class MockImageLoader: ImageLoaderProtocol {
        var statePublisher: Published<ImageLoaderState>.Publisher { $state }

        @Published private var state: ImageLoaderState = .initial

        func load(with imageWidth: Int?) {
            let image = UIImage(named: "Logo")!
            state = .success(image)
        }
    }

    static let imageLoader = MockImageLoader()
    static var previews: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let viewModel = AsyncImageViewModel(imageLoader: imageLoader,
                                                imageWidth: Int(width))
            AsyncImage(viewModel: viewModel,
                       placeholder: {
                           Text("loading")
                       },
                       image: { image in
                           Image(uiImage: image)
                       },
                       error: { _ in
                           Image("Logo")
                       })
        }
    }
}
