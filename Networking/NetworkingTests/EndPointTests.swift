//
//  EndPointTests.swift
//  NetworkingTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import XCTest
@testable import Networking

final class EndPointTests: XCTestCase {
    
    // MARK: - Tests
    func testCreateRequestCorrectly() throws {
        let expectedUrl = "https://google.com?test=1"
        let expectedMethod = "GET"
        let expectedHeaders = ["test":"test"]
        
        let request = MockEndpoint.someEndpoint.createRequest()
        
        let unwrappedUrl = try XCTUnwrap(request?.url)
        XCTAssertEqual(unwrappedUrl.absoluteString, expectedUrl)
        XCTAssertEqual(expectedMethod, request?.httpMethod)
        let unwrappedHeaders = try XCTUnwrap(request?.allHTTPHeaderFields)
        XCTAssertEqual(unwrappedHeaders, expectedHeaders)
    }
}

// MARK: - MockEndpoint
private enum MockEndpoint: EndPoint {
    
    case someEndpoint
    
    var url: URL {
        return URL(string: "https://google.com")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String] {
        return ["test":"test"]
    }
    
    var queryParameters: [String : Any] {
        return ["test": 1]
    }
}
