//
//  ProductListViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Foundation

struct ProductListViewModel: ProductListViewModelProtocol {
    private let products: Products

    init(products: Products) {
        self.products = products
    }

    var indices: Range<Int> { products.indices }

    func productCellViewModel(for index: Int) -> ProductCellViewModelProtocol {
        let product = products[index]
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductCellViewModel(product: product,
                                    imageLoader: imageLoader)
    }
    
    func productDetailViewModel(for index: Int) -> ProductDetailViewModelProtocol {
        let product = products[index]
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductDetailViewModel(product: product,
                                      imageLoader: imageLoader)
    }
}
