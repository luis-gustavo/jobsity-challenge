//
//  UIView+addSubviewsTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import XCTest
@testable import Jobsity

final class UIView_addSubviewsTests: XCTestCase {

    // MARK: - Properties
    private let view = UIView()
    
    // MARK: - Tests
    func testAddSubviewsCorrectly() {
        let expectedSubViewsAmount = 2
        let expectedTranslatesAutoresizingMaskIntoConstraints = false

        let dummyView1 = UIView()
        let dummyView2 = UIView()
        view.addSubviews([dummyView1, dummyView2])
        
        XCTAssertEqual(view.subviews.count, expectedSubViewsAmount)
        XCTAssertEqual(dummyView1.translatesAutoresizingMaskIntoConstraints, expectedTranslatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(dummyView2.translatesAutoresizingMaskIntoConstraints, expectedTranslatesAutoresizingMaskIntoConstraints)
    }
}
