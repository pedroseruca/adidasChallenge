//
//  ProductDetailViewModelProtocol.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

protocol ProductDetailViewModelProtocol {
    var name: String { get }
    var description: String { get }
    var price: String { get }
    
    var reviewsViewModel: ProductReviewsViewModelProtocol { get }

    func imageViewModel(for imageWidth: Float) -> AsyncImageViewModel
}
