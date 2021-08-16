//
//  AdidasAPITest.swift
//  AdidasChallengeTests
//
//  Created by Pedro Seruca on 16/08/2021.
//

@testable import AdidasChallenge
import XCTest

class AdidasAPITest: XCTestCase {
    var api: AdidasAPI!
    var mockServiceManager: MockServiceManager!

    override func setUp() {
        super.setUp()
        mockServiceManager = MockServiceManager()
        api = AdidasAPI(serviceManager: mockServiceManager)
    }

    override func tearDown() {
        api = nil
        mockServiceManager = nil
        super.tearDown()
    }

    func test_getProducts_url() throws {
        _ = api.getProducts()
            .sink { _ in } receiveValue: { _ in
                XCTFail()
            }
        XCTAssertTrue(mockServiceManager.isExecuteCalled)

        let request = try XCTUnwrap(mockServiceManager.lastRequest)
        XCTAssertEqual(request.httpMethod, "GET")
        let url = request.url
        XCTAssertEqual(url?.absoluteString, "http://localhost:3001/product")
    }
    
    func test_getReviews_url() throws {
        _ = api.getReview(for: "")
            .sink { _ in } receiveValue: { _ in
                XCTFail()
            }
        XCTAssertTrue(mockServiceManager.isExecuteCalled)

        let request = try XCTUnwrap(mockServiceManager.lastRequest)
        XCTAssertEqual(request.httpMethod, "GET")
        let url = request.url
        XCTAssertEqual(url?.absoluteString, "http://localhost:3002/reviews/")
    }
    
    func test_postReviews_url() throws {
        _ = api.postReview(for: "Example", review: MockProductReviews.default[0])
            .sink { _ in } receiveValue: { _ in
                XCTFail()
            }
        XCTAssertTrue(mockServiceManager.isExecuteCalled)
        let request = try XCTUnwrap(mockServiceManager.lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json; charset=utf-8")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json; charset=utf-8")
        let url = request.url
        XCTAssertEqual(url?.absoluteString, "http://localhost:3002/reviews/Example")
    }
}
