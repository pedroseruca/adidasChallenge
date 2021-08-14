//
//  ProductListModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 14/08/2021.
//

struct ProductListModel: Identifiable {
    var id: String
    var cellViewModelProtocol: ProductCellViewModelProtocol
    var detailViewModelProtocol: ProductDetailViewModelProtocol
}
