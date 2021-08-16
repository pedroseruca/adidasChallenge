//
//  AdidasFactory.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

import Foundation

class AdidasFactory {
    // MARK: Private Properties

    private let serviceManager: ServiceManagerProtocol

    private lazy var adidasAPI = AdidasAPI(serviceManager: serviceManager)

    // MARK: Lifecycle

    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }

    // MARK: Private Methods

    private func makeImageLoader(for product: Product) -> ImageLoaderProtocol {
        ImageLoader(for: product.imgUrl)
    }
}

extension AdidasFactory: ProductListFactory {
    func makeProductListViewModel() -> ProductListViewModel {
        ProductListViewModel(adidasAPI: adidasAPI, factory: self)
    }
}

extension AdidasFactory: ProductCellFactory {
    func makeProductCellViewModel(for product: Product) -> ProductCellViewModelProtocol {
        let imageLoader = makeImageLoader(for: product)
        return ProductCellViewModel(product: product,
                                    imageLoader: imageLoader)
    }
}

extension AdidasFactory: ProductDetailFactory {
    func makeProductDetailViewModel(for product: Product) -> ProductDetailViewModel {
        let imageLoader = makeImageLoader(for: product)
        return ProductDetailViewModel(product: product,
                                      imageLoader: imageLoader,
                                      adidasAPI: adidasAPI,
                                      factory: self)
    }
}

extension AdidasFactory: ProductReviewsFactory {
    func makeProductReviewsViewModel(for product: Product,
                                     with reviews: ProductReviews,
                                     onReviewSubmitted: @escaping () -> Void) -> ProductReviewsViewModel {
        ProductReviewsViewModel(
            product: product,
            reviews: reviews,
            factory: self,
            onReviewSubmitted: onReviewSubmitted)
    }

    func makeAddReviewViewModel(for product: Product, onReviewSubmitted: @escaping () -> Void) -> AddReviewViewModel {
        AddReviewViewModel(product: product,
                           adidasAPI: adidasAPI,
                           onReviewSubmitted: onReviewSubmitted)
    }
}
