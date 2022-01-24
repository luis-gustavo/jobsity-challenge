//
//  EpisodeCellTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class EpisodeCellTests: XCTestCase {

    // MARK: - Properties
    private let sut = EpisodeCell()
    
    // MARK: - Tests
    func testEpisodeCellHasCorrectLayout() {
        sut.configureWith(name: "The first episode", season: 1, number: 1, image: "")
        sut.frame = .init(origin: .zero, size: .init(width: 300, height: 700))
        assertSnapshot(matching: sut, as: .image)
    }
}
