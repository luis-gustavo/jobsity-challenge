//
//  UIStackView+addArrangedSubviewsTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import XCTest
@testable import Jobsity

final class UIStackView_addArrangedSubviewsTests: XCTestCase {
    
    // MARK: - Properties
    private let stackView = UIStackView()
    
    // MARK: - Tests
    func testAddArrangedSubviewsCorrectly() {
        let expectedArrangedViewsAmount = 2
        let expectedTranslatesAutoresizingMaskIntoConstraints = false

        let dummyView1 = UIView()
        let dummyView2 = UIView()
        stackView.addArrangedSubviews([dummyView1, dummyView2])
        
        XCTAssertEqual(stackView.arrangedSubviews.count, expectedArrangedViewsAmount)
        XCTAssertEqual(dummyView1.translatesAutoresizingMaskIntoConstraints, expectedTranslatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(dummyView2.translatesAutoresizingMaskIntoConstraints, expectedTranslatesAutoresizingMaskIntoConstraints)
    }
}
