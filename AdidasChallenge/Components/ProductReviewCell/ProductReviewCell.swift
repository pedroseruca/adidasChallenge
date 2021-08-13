//
//  ProductReviewCell.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import SwiftUI

struct ProductReviewCell: View {
    private let viewModel: ProductReviewCellViewModelProtocol

    init(viewModel: ProductReviewCellViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            Text("\(viewModel.rating)")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .frame(minWidth: 25)
            Text(viewModel.text)
        }
    }
}

struct ProductReviewCell_Previews: PreviewProvider {
    private static let review = ProductReview(productId: "HI333", locale: "en-us", rating: 0, text: "test")
    private static let viewModel = ProductReviewCellViewModel(review: review)
    static var previews: some View {
        ProductReviewCell(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
