//
//  ProductDetailInfoView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import SwiftUI

struct ProductDetailInfoView: View {
    private let viewModel: ProductDetailViewModelProtocol

    init(viewModel: ProductDetailViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.name)
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
                Text(viewModel.price)
                    .font(.title2)
            }
            Text(viewModel.description)
        }.padding(.all)
    }
}

struct ProductDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailInfoView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}

private extension ProductDetailInfoView_Previews {
    static let product = Product(
        id: "HI333",
        name: "Sapatos Forum 84 BB",
        description: "Description Description",
        currency: "$",
        price: 160,
        imgUrl: ""
    )
    static let viewModel = makeViewModel(with: product)
}

private extension ProductDetailInfoView_Previews {
    static func makeViewModel(with product: Product) -> ProductDetailViewModelProtocol {
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductDetailViewModel(product: product,
                                      imageLoader: imageLoader)
    }
}
