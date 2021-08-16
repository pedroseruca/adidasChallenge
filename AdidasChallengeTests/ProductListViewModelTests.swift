//
//  ProductListViewModelTests.swift
//  AdidasChallengeTests
//
//  Created by Pedro Seruca on 09/08/2021.
//

@testable import AdidasChallenge
import XCTest

class ProductListViewModelTests: XCTestCase {
    var viewModel: ProductListViewModel!
    var mockAdidasAPI: MockAdidasAPI!
    var mockFactory: MockAdidasFactory!

    override func setUp() {
        super.setUp()
        mockFactory = MockAdidasFactory()
        mockAdidasAPI = MockAdidasAPI()
        viewModel = ProductListViewModel(adidasAPI: mockAdidasAPI,
                                         factory: mockFactory)
    }

    override func tearDown() {
        viewModel = nil
        mockAdidasAPI = nil
        mockFactory = nil
        super.tearDown()
    }

    func testNavigationTitle() {
        let title = viewModel.navigationTitle
        XCTAssertEqual(title, "Search")
    }

    func testInitial_NoProductsMessage() {
        let message = viewModel.noProductsMessage
        XCTAssertEqual(message, "There is no products on our shop yet.")
    }

    func testInitial_ShowNoProductsMessage() {
        let state = viewModel.showNoProductsMessage
        XCTAssertFalse(state)
    }

    func testInitial_models() {
        let models = viewModel.models
        XCTAssertNil(models)
    }
    
    func test_viewDidAppear_callAdidasAPI() {
        mockAdidasAPI.getProductsResult = .failure(GenericError.standard)
        
        viewModel.viewDidAppear()
        XCTAssertTrue(mockAdidasAPI.isGetProductsCalled)
    }
    
    func test_viewDidAppear_successEmpty() throws {
        mockAdidasAPI.getProductsResult = .success(MockProducts.empty)
        
        viewModel.viewDidAppear()
        XCTAssertTrue(mockAdidasAPI.isGetProductsCalled)
        
        let models = try XCTUnwrap(viewModel.models)
        XCTAssertTrue(models.isEmpty)
        
        XCTAssertTrue(viewModel.showNoProductsMessage)
    }
    
    func test_viewDidAppear_successFilled() throws {
        mockAdidasAPI.getProductsResult = .success(MockProducts.default)
        mockFactory.productDetailViewModel = .init(product: MockProducts.default[0],
                                                   imageLoader: MockImageLoader(),
                                                   adidasAPI: mockAdidasAPI,
                                                   factory: mockFactory)
        
        mockFactory.productCellViewModel = .init(product: MockProducts.default[0],
                                                 imageLoader: MockImageLoader())
        
        viewModel.viewDidAppear()
        XCTAssertTrue(mockAdidasAPI.isGetProductsCalled)
        
        let models = try XCTUnwrap(viewModel.models)
        XCTAssertFalse(models.isEmpty)
        XCTAssertFalse(viewModel.showNoProductsMessage)
        
        XCTAssertEqual(models.count, 3)
        
        XCTAssertTrue(mockFactory.isMakeProductCellViewModelCalled)
        XCTAssertTrue(mockFactory.isMakeProductDetailViewModelCalled)
    }
    
    func test_search_noProducts() throws {
        mockAdidasAPI.getProductsResult = .success(MockProducts.default)
        mockFactory.productDetailViewModel = .init(product: MockProducts.default[0],
                                                   imageLoader: MockImageLoader(),
                                                   adidasAPI: mockAdidasAPI,
                                                   factory: mockFactory)
        
        mockFactory.productCellViewModel = .init(product: MockProducts.default[0],
                                                 imageLoader: MockImageLoader())
        viewModel.viewDidAppear()
        let models = try XCTUnwrap(viewModel.models)
        XCTAssertFalse(models.isEmpty)
        
        viewModel.searchProduct(for: "Example")
        let models2 = try XCTUnwrap(viewModel.models)
        XCTAssertTrue(models2.isEmpty)
        
        XCTAssertTrue(viewModel.showNoProductsMessage)
        XCTAssertEqual(viewModel.noProductsMessage, "There is no products for that search. \nTry another word.")
    }
    
    func test_search_withProducts() throws {
        mockAdidasAPI.getProductsResult = .success(MockProducts.default)
        mockFactory.productDetailViewModel = .init(product: MockProducts.default[0],
                                                   imageLoader: MockImageLoader(),
                                                   adidasAPI: mockAdidasAPI,
                                                   factory: mockFactory)
        
        mockFactory.productCellViewModel = .init(product: MockProducts.default[0],
                                                 imageLoader: MockImageLoader())
        viewModel.viewDidAppear()
        let models = try XCTUnwrap(viewModel.models)
        XCTAssertFalse(models.isEmpty)
        
        viewModel.searchProduct(for: "Description")
        let models2 = try XCTUnwrap(viewModel.models)
        XCTAssertFalse(models2.isEmpty)
        
        XCTAssertFalse(viewModel.showNoProductsMessage)
    }
}


