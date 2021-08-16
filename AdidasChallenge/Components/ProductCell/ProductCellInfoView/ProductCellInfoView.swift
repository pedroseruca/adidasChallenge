//
//  ProductCellInfoView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import SwiftUI

struct ProductCellInfoView: View {
    // MARK: Private Properties

    private let viewModel: ProductCellViewModelProtocol
    private let padding: CGFloat = 5

    // MARK: Lifecycle

    init(viewModel: ProductCellViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: Public Properties

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
                .font(.title3)
                .fontWeight(.medium)
                .padding(padding)
            Text(viewModel.description)
                .font(.subheadline)
                .padding(padding)
            Text(viewModel.price)
                .font(.headline)
                .fontWeight(.medium)
                .padding(padding)
        }
    }
}

// MARK: SwiftUI Previews

struct ProductCellInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellInfoView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}

private extension ProductCellInfoView_Previews {
    private static let product = Product(
        id: "HI333",
        name: "Cassina pt",
        description: "Description Description Description Description",
        currency: "$",
        price: 160,
        imgUrl: "https://assets.adidas.com/images/w_276,h_276,f_auto,q_auto:sensitive,fl_lossy/da278c9c5e244068b32cac4d0125fedd_9366/FY2002_00_plp_standard.jpg"
    )

    static let viewModel = makeViewModel(with: product)
}

private extension ProductCellInfoView_Previews {
    static func makeViewModel(with product: Product) -> ProductCellViewModelProtocol {
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductCellViewModel(product: product,
                                    imageLoader: imageLoader)
    }
}
