//
//  ProductReviewsViewModelProtocol.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

protocol ProductReviewsViewModelProtocol {
    var indices: Range<Int> { get }
    
    func productReviewCellViewModel(for index: Int) -> ProductReviewCellViewModelProtocol
}
