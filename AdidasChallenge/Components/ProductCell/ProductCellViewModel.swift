//
//  ProductCellViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

class ProductCellViewModel: ProductCellViewModelProtocol {
    // MARK: Private Properties

    private let product: Product
    private let imageLoader: ImageLoaderProtocol

    // MARK: Lifecycle

    init(product: Product, imageLoader: ImageLoaderProtocol) {
        self.product = product
        self.imageLoader = imageLoader
    }

    // MARK: Public Properties

    private(set) lazy var name = product.name.uppercased()
    private(set) lazy var description = product.description
    private(set) lazy var price = "\(product.price) " + product.currency

    private(set) lazy var imageViewModel = AsyncImageViewModel(imageLoader: imageLoader)
}
