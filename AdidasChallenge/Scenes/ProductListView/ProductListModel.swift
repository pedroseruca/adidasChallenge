//
//  ProductListModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 14/08/2021.
//

struct ProductListModel: Identifiable {
    // MARK: Public Properties

    let id: String
    let cellViewModelProtocol: ProductCellViewModelProtocol
    let detailViewModel: ProductDetailViewModel
}
