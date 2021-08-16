//
//  AddReviewViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 16/08/2021.
//

import Combine

class AddReviewViewModel {
    // MARK: Private Properties

    private let product: Product
    private let adidasAPI: AdidasAPIReviewsProtocol
    private let onReviewSubmitted: () -> Void

    private let onSuccessSubmit: PassthroughSubject<Void, Never> = .init()
    private var subscriptions: Set<AnyCancellable> = .init()

    // MARK: Lifecycle

    init(product: Product,
         adidasAPI: AdidasAPIReviewsProtocol,
         onReviewSubmitted: @escaping () -> Void) {
        self.product = product
        self.adidasAPI = adidasAPI
        self.onReviewSubmitted = onReviewSubmitted
    }

    // MARK: Public Properties

    let navigationTitle = "Add review"
    private(set) lazy var titleLabel = "Rate " + product.name
    let shareOpinionLabel = "Share your opinion"
    let buttonTitle = "Submit"

    var onSuccessSubmitPublisher: AnyPublisher<Void, Never> { onSuccessSubmit.eraseToAnyPublisher() }

    // MARK: Public Methods

    func buttonPressed(rating: Int, text: String) {
        let review = ProductReview(productId: product.id,
                                   locale: "en-us",
                                   rating: rating,
                                   text: text)
        adidasAPI
            .postReview(for: product.id,
                        review: review)
            .sink { _ in

            } receiveValue: { [weak self] _ in
                self?.onReviewSubmitted()
                self?.onSuccessSubmit.send()
            }.store(in: &subscriptions)
    }
}
