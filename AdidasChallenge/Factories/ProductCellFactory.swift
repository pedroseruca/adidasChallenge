//
//  ProductCellFactory.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

protocol ProductCellFactory {
    func makeProductCellViewModel(for product: Product) -> ProductCellViewModelProtocol
}
