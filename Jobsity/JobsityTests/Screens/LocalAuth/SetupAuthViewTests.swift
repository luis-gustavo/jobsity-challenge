//
//  SetupAuthViewTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class SetupAuthViewTests: XCTestCase {

    // MARK: - Properties
    private var sut: SetupAuthView!
    
    // MARK: - TearDown
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Tests
    func testSetupAuthViewHasAuthEnabled() {
        sut = SetupAuthView(isAuthEnabled: true)
        sut.frame = .init(origin: .zero, size: .init(width: 300, height: 700))
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testSetupAuthViewHasAuthDisaled() {
        sut = SetupAuthView(isAuthEnabled: false)
        sut.frame = .init(origin: .zero, size: .init(width: 300, height: 700))
        
        assertSnapshot(matching: sut, as: .image)
    }
}
