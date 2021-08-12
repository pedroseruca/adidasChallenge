//
//  ProductDetailViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Foundation

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    private let product: Product
    private let imageLoader: ImageLoaderProtocol

    init(product: Product, imageLoader: ImageLoaderProtocol) {
        self.product = product
        self.imageLoader = imageLoader
    }

    private(set) lazy var name = product.name.uppercased()
    private(set) lazy var description = product.description
    private(set) lazy var price = "\(product.price) " + product.currency
    
    func imageViewModel(for imageWidth: Float) -> AsyncImageViewModel {
        .init(imageLoader: imageLoader,
              imageWidth: Int(imageWidth))
    }
}
