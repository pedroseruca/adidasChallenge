//
//  ProductDetailViewModelTest.swift
//  AdidasChallengeTests
//
//  Created by Pedro Seruca on 16/08/2021.
//

import Foundation

@testable import AdidasChallenge
import XCTest

class ProductDetailViewModelTest: XCTestCase {
    var viewModel: ProductDetailViewModel!
    var mockAdidasAPI: MockAdidasAPI!
    var mockFactory: MockAdidasFactory!
    var mockImageLoader: MockImageLoader!
    var mockProduct: Product = MockProducts.default[0]
    
    override func setUp() {
        super.setUp()
        mockImageLoader = MockImageLoader()
        mockFactory = MockAdidasFactory()
        mockAdidasAPI = MockAdidasAPI()
        viewModel = ProductDetailViewModel(
            product: mockProduct,
            imageLoader: mockImageLoader,
            adidasAPI: mockAdidasAPI,
            factory: mockFactory)
    }

    override func tearDown() {
        viewModel = nil
        mockAdidasAPI = nil
        mockFactory = nil
        mockImageLoader = nil
        super.tearDown()
    }

    func test_name(){
        let name = viewModel.name
        XCTAssertEqual(name, mockProduct.name.uppercased())
    }
    
    func test_description() {
        let description = viewModel.description
        XCTAssertEqual(description, mockProduct.description)
    }
    
    func test_price() {
        let price = viewModel.price
        let expectedPrice = "\(mockProduct.price) " + mockProduct.currency
        XCTAssertEqual(price, expectedPrice)
    }
    
    func testInitial_reviewsViewModel() {
        let models = viewModel.reviewsViewModel
        XCTAssertNil(models)
    }
    
    func test_viewDidAppear() {
        mockAdidasAPI.getReviewsResult = .failure(GenericError.standard)
        
        viewModel.viewDidAppear()
        XCTAssertTrue(mockAdidasAPI.isGetReviewCalled)
    }
    
    func test_viewDidAppear_successEmpty() throws {
        mockAdidasAPI.getReviewsResult = .success(MockProductReviews.empty)
        mockFactory.productReviewsViewModel = .init(product: MockProducts.default[0],
                                                    reviews: MockProductReviews.empty,
                                                    factory: mockFactory,
                                                    onReviewSubmitted: {})
        
        viewModel.viewDidAppear()
        XCTAssertTrue(mockAdidasAPI.isGetReviewCalled)
        XCTAssertTrue(mockFactory.isMakeProductReviewsViewModelCalled)
        
        let models = try XCTUnwrap(viewModel.reviewsViewModel)
        XCTAssertTrue(models.models.isEmpty)
        
    }
}
