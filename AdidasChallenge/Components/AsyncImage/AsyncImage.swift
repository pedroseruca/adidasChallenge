//
//  AsyncImage.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import Combine
import SwiftUI

// TODO: Add Documentation. AsyncImage is natively for iOS15+ which is still in beta. This is an inspired class to help manage the load process of an image.

struct AsyncImage<Placeholder, ImageLoader, ImageView, NoImageView>: View where
    Placeholder: View,
    ImageView: View,
    NoImageView: View,
    ImageLoader: ImageLoaderProtocol {
    @ObservedObject private var imageLoader: ImageLoader

    private let placeholderBuilder: () -> Placeholder
    private let imageBuilder: (UIImage) -> ImageView
    private let errorBuilder: (Error) -> NoImageView

    init(imageLoader: ImageLoader,
         @ViewBuilder placeholder: @escaping () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> ImageView,
         @ViewBuilder error: @escaping (Error) -> NoImageView) {
        self.imageLoader = imageLoader
        placeholderBuilder = placeholder
        imageBuilder = image
        errorBuilder = error
    }

    var body: some View {
        content
            .onAppear { imageLoader.load() }
    }

    private var content: some View {
        Group {
            switch imageLoader.state {
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
        @Published var state: ImageLoaderState = .initial

        func load() {
            let image = UIImage(named: "Logo")!
            print(image)
            state = .success(image)
        }
    }

    static let imageLoader = MockImageLoader()
    static var previews: some View {
        AsyncImage(imageLoader: imageLoader,
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
