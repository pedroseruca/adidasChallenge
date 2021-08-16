//
//  ProductReviewsViewModelProtocol.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

protocol ProductReviewsViewModelProtocol {
    var models: [ProductReviewCellViewModel] { get }
        
    var averageRating: String { get }
    var ratingsCount: String { get }
    var ratingsCountValue: Int { get }
    
    var addReviewButtonTitle: String { get }
    var noReviewsMessage: String { get }
    
    var addReviewViewModel: AddReviewViewModel { get }
}
