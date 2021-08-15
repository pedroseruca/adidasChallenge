//
//  ProductDetailFactory.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

protocol ProductDetailFactory {
    func makeProductDetailViewModel(for product: Product) -> ProductDetailViewModel
}
