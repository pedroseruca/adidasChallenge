//
//  ProductCell.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 10/08/2021.
//

import SwiftUI

struct ProductCell: View {
    private let viewModel: ProductCellViewModelProtocol
    // TODO: Make a file for styles
    private let imageSize: CGFloat = 120
    private let padding: CGFloat = 5
    private let imageLeadingPadding: CGFloat = 10
    private let imageCornerRadius: CGFloat = 5

    init(viewModel: ProductCellViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            AsyncImage(viewModel: viewModel.imageViewModel) {
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
    static var previews: some View {
        Group {
            ProductCell(viewModel: viewModel1)
                .previewLayout(.fixed(width: 400, height: 150))
            ProductCell(viewModel: viewModel2)
                .previewLayout(.fixed(width: 400, height: 150))
        }
    }
}

// MARK: Preview #1

private extension ProductCell_Previews {
    private static let product1 = Product(
        id: "HI333",
        name: "Cassina pt",
        description: "Description Description Description Description",
        currency: "$",
        price: 160,
        imgUrl: "https://assets.adidas.com/images/w_276,h_276,f_auto,q_auto:sensitive,fl_lossy/da278c9c5e244068b32cac4d0125fedd_9366/FY2002_00_plp_standard.jpg"
    )
    static let viewModel1 = makeViewModel(with: product1)
}

// MARK: Preview #2

private extension ProductCell_Previews {
    private static let product2 = Product(
        id: "HI333",
        name: "Cassina pt",
        description: "Description Description Description Description",
        currency: "$",
        price: 160,
        imgUrl: "https://assets.adidas.com/images/w_276,h_276,f_auto,q_auto:sensitive,fl_lossy/da278c9c5e244068b32cac4d0125fedd_9366/FY2002_00_plp_standard.jpg"
    )

    static let viewModel2 = makeViewModel(with: product2)
}

private extension ProductCell_Previews {
    static func makeViewModel(with product: Product) -> ProductCellViewModelProtocol {
        let imgUrl = URL(string: product.imgUrl)
        let imageLoader = ImageLoader(for: imgUrl)
        return ProductCellViewModel(product: product,
                                    imageLoader: imageLoader)
    }
}
