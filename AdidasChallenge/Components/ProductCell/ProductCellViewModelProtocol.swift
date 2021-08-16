//
//  ProductCellViewModelProtocol.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

protocol ProductCellViewModelProtocol {
    var name: String { get }
    var description: String { get }
    var price: String { get }

    var imageViewModel: AsyncImageViewModel { get }
}
