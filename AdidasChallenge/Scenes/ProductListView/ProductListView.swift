//
//  InitialView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 09/08/2021.
//

import SwiftUI

struct ProductListView: View {
    private let viewModel: ProductListViewModelProtocol

    init(viewModel: ProductListViewModelProtocol) {
        self.viewModel = viewModel
    }

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText)
                    .padding(.horizontal)

                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.indices) { index in
                            let cellViewModel = viewModel.productCellViewModel(for: index)
                            let detailViewModel = viewModel.productDetailViewModel(for: index)
                            let productDetailView = ProductDetailView(viewModel: detailViewModel)
                            NavigationLink(destination: productDetailView) {
                                ProductCell(viewModel: cellViewModel)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    private static let viewModel = ProductListViewModel(products: mockProducts)
    static var previews: some View {
        ProductListView(viewModel: viewModel)
    }
}

private extension InitialView_Previews {
    private static let mockProducts = [
        Product(
            id: "HI333",
            name: "product",
            description: "description",
            currency: "$",
            price: 4,
            imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c7099422ccc14e44b406abec00ba6c96_9366/NMD_R1_V2_Shoes_Black_FY6862_01_standard.jpg"
        ),
        Product(
            id: "HI334",
            name: "product",
            description: "description",
            currency: "$",
            price: 87,
            imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c93fa315d2f64775ac1fab96016f09d1_9366/Dame_6_Shoes_Black_FV8624_01_standard.jpg"
        ),
        Product(
            id: "HI336",
            name: "product",
            description: "description",
            currency: "$",
            price: 36,
            imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/3eebc0498b1347e397f8ab94016140ba_9366/FS1496_00_plp_standard.jpg"
        ),
    ]
}
