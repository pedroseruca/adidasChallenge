//
//  ProductCellViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import Foundation

protocol ProductCellViewModelProtocol {
    associatedtype Loader: ImageLoaderProtocol
    
    var name: String { get }
    var description: String { get }
    var price: String { get }
    
    var imageLoader: Loader { get }
}

class ProductCellViewModel: ProductCellViewModelProtocol {
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    private(set) lazy var name = product.name
    private(set) lazy var description = product.description
    private(set) lazy var price = "\(product.price)"
    
    private(set) lazy var imageLoader: ImageLoader = {
        let imgUrl = URL(string: product.imgUrl)
        return ImageLoader(for: imgUrl)
    }()
}
