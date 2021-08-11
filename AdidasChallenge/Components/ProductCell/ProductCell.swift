//
//  ProductCell.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import SwiftUI

struct ProductCell<ViewModel>: View where
    ViewModel: ProductCellViewModelProtocol {
    private let viewModel: ViewModel

    private let imageSize: CGFloat = 120
    private let imageLeadingPadding: CGFloat = 10
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            AsyncImage(imageLoader: viewModel.imageLoader) {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
                    .scaleEffect(1.5)
            } image: { image in
                Image(uiImage: image)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
            } error: { _ in
                // TODO: Make a file for assets names
                Image("NoImageAvailable")
            }

            VStack {
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
            }.padding(.leading, imageLeadingPadding)
                Text(viewModel.name)
                Text(viewModel.description)
                Text(viewModel.price)
            }
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    private static let mockProduct = Product(
        id: "HI333",
        name: "product",
        description: "description",
        currency: "$",
        price: 4,
        imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c7099422ccc14e44b406abec00ba6c96_9366/NMD_R1_V2_Shoes_Black_FY6862_01_standard.jpg"
    )
    private static let viewModel = ProductCellViewModel(product: mockProduct)
    static var previews: some View {
        ProductCell(viewModel: viewModel)
    }
}
