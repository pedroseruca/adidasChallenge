//
//  ProductDetailViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Combine
import Foundation
import os

class ProductDetailViewModel: ObservableObject {
    // MARK: Private Properties

    private let product: Product
    private let imageLoader: ImageLoaderProtocol
    private let adidasAPI: AdidasAPIReviewsProtocol
    private let factory: ProductReviewsFactory

    private var subscriptions: Set<AnyCancellable> = .init()

    // MARK: Lifecycle

    init(product: Product,
         imageLoader: ImageLoaderProtocol,
         adidasAPI: AdidasAPIReviewsProtocol,
         factory: ProductReviewsFactory) {
        self.product = product
        self.imageLoader = imageLoader
        self.adidasAPI = adidasAPI
        self.factory = factory
    }

    // MARK: Public Properties

    @Published private(set) var reviewsViewModel: ProductReviewsViewModelProtocol? = nil
    @Published var showingAlert = true
    
    private(set) lazy var name = product.name.uppercased()
    private(set) lazy var description = product.description
    private(set) lazy var price = "\(product.price) " + product.currency

    // MARK: Public Methods

    func imageViewModel(for imageWidth: Float) -> AsyncImageViewModel {
        .init(imageLoader: imageLoader,
              imageWidth: Int(imageWidth))
    }

    func viewDidAppear() {
        updateReviews()
    }
    
    func retryAlertButtonPressed() {
        showingAlert = false
        updateReviews()
    }

    // MARK: Private Methods

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
            .sink { [weak self] error in
                switch error {
                case let .failure(errorContent):
                    self?.showingAlert = true
                    
                    let text: StaticString = "getReview request gave an error for product: %@. Error: %@"
                    let errorString = "\(errorContent)"
                    guard let productID = self?.product.id else { return }
                    os_log(text, type: .error, productID, errorString)
                default:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.reviewsViewModel = response
            }.store(in: &subscriptions)
    }
}
