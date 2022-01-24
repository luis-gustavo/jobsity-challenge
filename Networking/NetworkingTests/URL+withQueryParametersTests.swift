//
//  URL+withQueryParametersTests.swift
//  NetworkingTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import XCTest
@testable import Networking

final class URL_withQueryParametersTests: XCTestCase {
    
    // MARK: - Properties
    private let sampleURL = URL(string: "https://google.com")!

    // MARK: - Tests
    func testURLHasCorrectQueryParameters() throws {
        let expectedResult = "https://google.com?test=1"
        let queryParameters: [String: Any] = ["test": 1]
        let urlWithQueryParameters = sampleURL.with(queryParameters: queryParameters)
        let unwrappedUrl = try XCTUnwrap(urlWithQueryParameters)
        XCTAssertEqual(unwrappedUrl.absoluteString, expectedResult)
    }

}
