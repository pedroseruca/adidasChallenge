//
//  ProductDetailViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    associatedtype Loader: ImageLoaderProtocol
    
    var name: String { get }
    var description: String { get }
    var price: String { get }
    
    var imageLoader: Loader { get }
}

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    private let product: Product
    
    required init(product: Product) {
        self.product = product
    }
    
    private(set) lazy var name = product.name.uppercased()
    private(set) lazy var description = product.description
    private(set) lazy var price = "\(product.price) " + product.currency
    
    private(set) lazy var imageLoader: ImageLoader = {
        let imgUrl = URL(string: product.imgUrl)
        return ImageLoader(for: imgUrl)
    }()
}
