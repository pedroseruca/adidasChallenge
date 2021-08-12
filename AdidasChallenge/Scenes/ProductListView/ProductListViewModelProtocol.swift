//
//  ProductListViewModelProtocol.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

protocol ProductListViewModelProtocol {
    var indices: Range<Int> { get }
    func productCellViewModel(for index: Int) -> ProductCellViewModelProtocol
    func productDetailViewModel(for index: Int) -> ProductDetailViewModelProtocol
}
