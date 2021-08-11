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
    // TODO: Make a file for styles
    private let imageSize: CGFloat = 120
    private let padding: CGFloat = 5
    private let imageLeadingPadding: CGFloat = 10
    private let imageCornerRadius: CGFloat = 5

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
                    .cornerRadius(imageCornerRadius)
            } error: { _ in
                // TODO: Make a file for assets names
                Image("NoImageAvailable")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
            }.padding(.leading, imageLeadingPadding)

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
            Spacer()
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    private static let mockProduct = Product(
        id: "HI333",
        name: "Sapatos Forum 84 BB",
        description: "Description Description Description Description",
        currency: "$",
        price: 160,
        imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c7099422ccc14e44b406abec00ba6c96_9366/NMD_R1_V2_Shoes_Black_FY6862_01_standard.jpg"
    )
    private static let viewModel = ProductCellViewModel(product: mockProduct)
    static var previews: some View {
        ProductCell(viewModel: viewModel)
    }
}
