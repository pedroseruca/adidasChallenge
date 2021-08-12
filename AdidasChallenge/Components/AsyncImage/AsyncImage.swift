//
//  AsyncImage.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import Combine
import SwiftUI

// TODO: Add Documentation. AsyncImage is natively for iOS15+ which is still in beta. This is an inspired class to help manage the load process of an image.

struct AsyncImage<Placeholder, ImageView, NoImageView>: View where
    Placeholder: View,
    ImageView: View,
    NoImageView: View {
    @ObservedObject private var viewModel: AsyncImageViewModel

    private let placeholderBuilder: () -> Placeholder
    private let imageBuilder: (UIImage) -> ImageView
    private let errorBuilder: (Error) -> NoImageView

    init(viewModel: AsyncImageViewModel,
         @ViewBuilder placeholder: @escaping () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> ImageView,
         @ViewBuilder error: @escaping (Error) -> NoImageView) {
        self.viewModel = viewModel
        placeholderBuilder = placeholder
        imageBuilder = image
        errorBuilder = error
    }

    var body: some View {
        content
            .onAppear { self.viewModel.load() }
    }

    private var content: some View {
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
    }
}

struct ProductImage_Previews: PreviewProvider {
    class MockImageLoader: ImageLoaderProtocol {
        var statePublisher: Published<ImageLoaderState>.Publisher { $state }

        @Published private var state: ImageLoaderState = .initial

        func load(with imageWidth: Int?) {
            let image = UIImage(named: "Logo")!
            print(image)
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
