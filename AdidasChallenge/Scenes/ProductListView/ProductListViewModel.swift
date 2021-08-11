//
//  ProductListViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

protocol ProductListViewModelProtocol {
    var indices: Range<Int> { get }
    func productCellViewModel<ViewModel>(for index: Int) -> ViewModel where
        ViewModel: ProductCellViewModelProtocol,
        ViewModel: ProductCellViewModelInitializer
}

struct ProductListViewModel: ProductListViewModelProtocol {
    private let products: Products
    
    init(products: Products) {
        self.products = products
    }
    
    var indices: Range<Int> { products.indices}

    func productCellViewModel<ViewModel>(for index: Int) -> ViewModel where
        ViewModel: ProductCellViewModelProtocol,
        ViewModel: ProductCellViewModelInitializer {
        .init(product: products[index])
    }
}
