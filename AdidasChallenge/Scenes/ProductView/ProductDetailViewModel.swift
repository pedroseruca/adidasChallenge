//
//  ProductDetailViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    var name: String { get }
    var description: String { get }
    var price: String { get }

    var imageViewModel: AsyncImageViewModel { get }
}

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

    private(set) lazy var imageViewModel = AsyncImageViewModel(imageLoader: imageLoader)
}
