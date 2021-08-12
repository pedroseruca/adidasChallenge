//
//  ProductListViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Foundation

protocol ProductListViewModelProtocol {
    var indices: Range<Int> { get }
    func productCellViewModel(for index: Int) -> ProductCellViewModelProtocol
    func productDetailViewModel(for index: Int) -> ProductDetailViewModelProtocol
}

struct ProductListViewModel: ProductListViewModelProtocol {
    private let products: Products

    init(products: Products) {
        self.products = products
    }

    var indices: Range<Int> { products.indices }

    func productCellViewModel(for index: Int) -> ProductCellViewModelProtocol {
        let product = products[index]
        let imgUrl = URL(string: product.imgUrl)
        let imageLoader = ImageLoader(for: imgUrl)
        return ProductCellViewModel(product: product,
                                    imageLoader: imageLoader)
    }
    
    func productDetailViewModel(for index: Int) -> ProductDetailViewModelProtocol {
        let product = products[index]
        let imgUrl = URL(string: product.imgUrl)
        let imageLoader = ImageLoader(for: imgUrl)
        return ProductDetailViewModel(product: product,
                                      imageLoader: imageLoader)
    }
}
