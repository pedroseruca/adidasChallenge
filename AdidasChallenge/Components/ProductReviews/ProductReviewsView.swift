//
//  ProductReviewsView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import SwiftUI

struct ProductReviewsView: View {
    private let viewModel: ProductReviewsViewModelProtocol

    init(viewModel: ProductReviewsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            
        }
    }
}

struct ProductReviewsView_Previews: PreviewProvider {
    private static let viewModel = ProductReviewsViewModel()
    static var previews: some View {
        ProductReviewsView(viewModel: viewModel)
    }
}
