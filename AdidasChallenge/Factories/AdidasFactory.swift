//
//  AdidasFactory.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

import Foundation

class AdidasFactory {
    let serviceManager: ServiceManagerProtocol

    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }

    private lazy var adidasAPI = AdidasAPI(serviceManager: serviceManager)
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
                                      adidasAPI: adidasAPI)
    }
}
