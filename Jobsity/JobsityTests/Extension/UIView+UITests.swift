//
//  UIView+UITests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import XCTest
@testable import Jobsity

final class UIView_UITests: XCTestCase {
    
    // MARK: - Properties
    private var sut: UIView!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        sut = UIView()
    }
    
    // MARK: - TearDown
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - Tests
    func testHasCorrectCornerRadius() {
        let expectedCornerRadius = CGFloat(10)
        let expectedMaskToBounds = true
        
        sut.cornerRadius = 10
        
        XCTAssertEqual(sut.layer.cornerRadius, expectedCornerRadius)
        XCTAssertEqual(sut.layer.masksToBounds, expectedMaskToBounds)
    }
    
    func testHasCorrectBorderWidth() {
        let expectedBorderWidth = CGFloat(10)
        
        sut.borderWidth = 10
        
        XCTAssertEqual(sut.layer.borderWidth, expectedBorderWidth)
    }
    
    func testHasCorrectBorderColor() {
        let expectedBorderColor = UIColor.black.cgColor
        
        sut.borderColor = .black
        
        XCTAssertEqual(sut.layer.borderColor, expectedBorderColor)
    }
}
