//
//  ProductDetailViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Combine
import Foundation

class ProductDetailViewModel: ObservableObject {
    private let product: Product
    private let imageLoader: ImageLoaderProtocol
    private let adidasAPI: AdidasAPIReviewsProtocol
    private let factory: ProductReviewsFactory

    init(product: Product,
         imageLoader: ImageLoaderProtocol,
         adidasAPI: AdidasAPIReviewsProtocol,
         factory: ProductReviewsFactory) {
        self.product = product
        self.imageLoader = imageLoader
        self.adidasAPI = adidasAPI
        self.factory = factory
    }

    @Published var reviewsViewModel: ProductReviewsViewModelProtocol? = nil

    private(set) lazy var name = product.name.uppercased()
    private(set) lazy var description = product.description
    private(set) lazy var price = "\(product.price) " + product.currency
    private var subscriptions: Set<AnyCancellable> = .init()

    func imageViewModel(for imageWidth: Float) -> AsyncImageViewModel {
        .init(imageLoader: imageLoader,
              imageWidth: Int(imageWidth))
    }

    func viewDidAppear() {
        updateReviews()
    }

    private func updateReviews() {
        adidasAPI
            .getReview(for: product.id)
            .map {
                self.factory.makeProductReviewsViewModel(
                    for: self.product,
                    with: $0,
                    onReviewSubmitted: { [weak self] in
                        self?.updateReviews()
                    })
            }
            .sink { error in
                print(error)
            } receiveValue: { [weak self] response in
                self?.reviewsViewModel = response
            }.store(in: &subscriptions)
    }
}
