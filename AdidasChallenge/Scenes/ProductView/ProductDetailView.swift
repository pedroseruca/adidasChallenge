//
//  ProductDetailView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import SwiftUI

struct ProductDetailView: View {
    private let viewModel: ProductDetailViewModelProtocol

    init(viewModel: ProductDetailViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width

            VStack {
                AsyncImage(viewModel: viewModel.imageViewModel(for: Float(width))) {
                    ProgressView()
                        .frame(width: width, height: width)
                        .scaleEffect(2)
                } image: { image in
                    Image(uiImage: image)
                        .frame(width: width,
                               height: width,
                               alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                } error: { _ in
                    Image("NoImageAvailable")
                        .resizable()
                        .frame(width: 300,
                               height: 300,
                               alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                }

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

            }.frame(maxHeight: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: viewModel)
    }
}

private extension ProductDetailView_Previews {
    static let product = Product(
        id: "HI333",
        name: "Sapatos Forum 84 BB",
        description: "Description Description",
        currency: "$",
        price: 160,
        imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c7099422ccc14e44b406abec00ba6c96_9366/NMD_R1_V2_Shoes_Black_FY6862_01_standard.jpg"
    )
    private static let viewModel = makeViewModel(with: product)
}

private extension ProductDetailView_Previews {
    static func makeViewModel(with product: Product) -> ProductDetailViewModelProtocol {
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductDetailViewModel(product: product,
                                      imageLoader: imageLoader)
    }
}
