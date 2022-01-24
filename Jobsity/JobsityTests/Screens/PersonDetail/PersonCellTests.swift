//
//  PersonCellTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class PersonCellTests: XCTestCase {

    // MARK: - Properties
    private let sut = PersonCell(frame: .init(origin: .zero, size: .init(width: 300, height: 700)))
    
    // MARK: - Tests
    func testPersonCellHasCorrectLayout() {
        sut.configureWith(name: "Adam Sandler", image: "")
        
        assertSnapshot(matching: sut, as: .image)
    }
    
}
