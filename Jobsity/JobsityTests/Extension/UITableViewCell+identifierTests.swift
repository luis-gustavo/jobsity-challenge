//
//  UITableViewCell+identifierTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import XCTest
@testable import Jobsity

final class UITableViewCell_identifierTests: XCTestCase {
    
    // MARK: - Tests
    func testHasCorrectIdentifier() {
        let expectedMock1Identifier = "Mock1TableViewCell"
        let expectedMock2Identifier = "Mock2TableViewCell"
        
        XCTAssertEqual(Mock1TableViewCell.identifier, expectedMock1Identifier)
        XCTAssertEqual(Mock2TableViewCell.identifier, expectedMock2Identifier)
        XCTAssertNotEqual(Mock1TableViewCell.identifier, Mock2TableViewCell.identifier)
    }
}

// MARK: - Mock1TableViewCell
private class Mock1TableViewCell: UITableViewCell { }

// MARK: - Mock2TableViewCell
private class Mock2TableViewCell: UITableViewCell { }
