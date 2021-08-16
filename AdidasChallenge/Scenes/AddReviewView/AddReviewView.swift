//
//  AddReviewView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 16/08/2021.
//

import Combine
import SwiftUI

struct AddReviewView: View {
    // MARK: InnerTypes
    
    private typealias Style = Constants.Style.AddReviewView
    
    // MARK: Private Properties

    private var viewModel: AddReviewViewModel

    @Environment(\.presentationMode) private var presentation
    private var ratingRound: Int { Int(rating) }

    // MARK: Lifecycle

    init(viewModel: AddReviewViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public Properties

    @State private var text: String = ""
    @State private var rating: Float = 5

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.titleLabel)
                .font(.title2)
                .padding(.bottom, Style.titlePadding)
            HStack {
                Text("\(ratingRound)")
                    .font(.title2)
                Slider(value: $rating, in: 0 ... 10, step: 1)
            }
            Text(viewModel.shareOpinionLabel)
                .font(.title3)
            TextEditor(text: $text)
                .frame(maxHeight: Style.TextEditor.maxHeight)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: Style.TextEditor.cornerRadius)
                        .stroke(Color.gray, lineWidth: Style.TextEditor.lineWidth)
                )
            Button(viewModel.buttonTitle) {
                viewModel.buttonPressed(rating: ratingRound, text: text)
            }
            .padding(Style.buttonBorderPadding)
            .buttonStyle(PrimaryButtonStyle(color: Style.buttonBorderColor))

            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(viewModel.navigationTitle)
        .onReceive(viewModel.onSuccessSubmitPublisher) { _ in
            self.presentation.wrappedValue.dismiss()
        }
    }
}

// MARK: SwiftUI Previews

struct AddReviewView_Previews: PreviewProvider {
    struct MockAdidasAPI: AdidasAPIReviewsProtocol {
        let reviews: ProductReviews
        func getReview(for productId: String) -> AnyPublisher<ProductReviews, Error> {
            Future { $0(.success(reviews)) }
                .eraseToAnyPublisher()
        }

        func postReview(for productId: String, review: ProductReview) -> AnyPublisher<Void, Error> {
            Future { $0(.success(())) }
                .eraseToAnyPublisher()
        }
    }

    private static let product = Product(
        id: "HI333",
        name: "product",
        description: "description",
        currency: "$",
        price: 4,
        imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c7099422ccc14e44b406abec00ba6c96_9366/NMD_R1_V2_Shoes_Black_FY6862_01_standard.jpg"
    )
    private static let viewModel = AddReviewViewModel(
        product: product,
        adidasAPI: MockAdidasAPI(reviews: []),
        onReviewSubmitted: {})
    static var previews: some View {
        AddReviewView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
