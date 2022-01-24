//
//  TVShowCellTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class TVShowCellTests: XCTestCase {

    // MARK: - Properties
    private var sut: TVShowCell!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        sut = TVShowCell()
        sut.frame = .init(origin: .zero, size: .init(width: 300, height: 700))
    }
    
    // MARK: - TearDown
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Tests
    func testTVShowCellHasCorrectLayoutAsFavorite() {
        sut.configureWith(name: "House", image: "true", isFavorite: true)
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testTVShowCellHasCorrectLayoutAsNotFavorite() {
        sut.configureWith(name: "House", image: "true", isFavorite: false)
        
        assertSnapshot(matching: sut, as: .image)
    }
}
