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

    init(product: Product,
         imageLoader: ImageLoaderProtocol,
         adidasAPI: AdidasAPIReviewsProtocol) {
        self.product = product
        self.imageLoader = imageLoader
        self.adidasAPI = adidasAPI
    }

    @Published var reviewsViewModel: ProductReviewsViewModelProtocol = ProductReviewsViewModel(reviews: [])

    private(set) lazy var name = product.name.uppercased()
    private(set) lazy var description = product.description
    private(set) lazy var price = "\(product.price) " + product.currency
    private var subscriptions: Set<AnyCancellable> = .init()

    func imageViewModel(for imageWidth: Float) -> AsyncImageViewModel {
        .init(imageLoader: imageLoader,
              imageWidth: Int(imageWidth))
    }

    func viewDidAppear() {
        adidasAPI
            .getReview(for: product.id)
            .map { ProductReviewsViewModel(reviews: $0) }
            .sink { error in
                print(error)
            } receiveValue: { [weak self] response in
                self?.reviewsViewModel = response
            }.store(in: &subscriptions)
    }
}
