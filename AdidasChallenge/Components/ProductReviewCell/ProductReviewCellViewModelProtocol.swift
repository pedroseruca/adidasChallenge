//
//  ProductReviewCellViewModelProtocol.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import Foundation

protocol ProductReviewCellViewModelProtocol {
    var id: UUID { get }
    var text: String { get }
    var rating: String { get }
}
