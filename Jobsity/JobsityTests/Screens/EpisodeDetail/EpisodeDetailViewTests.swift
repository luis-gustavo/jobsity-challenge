//
//  EpisodeDetailViewTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class EpisodeDetailViewTests: XCTestCase {
    
    // MARK: - Properties
    private let sut = EpisodeDetailView(model: .init(season: 1,
                                                     number: 1,
                                                     summary: "A good summary for this TV Show",
                                                     poster: ""))

    // MARK: - Tests
    func testEpisodeDetailViewHasCorrectLayout() {
        sut.frame = .init(origin: .zero, size: .init(width: 300, height: 700))
        
        assertSnapshot(matching: sut, as: .image)
    }
}
