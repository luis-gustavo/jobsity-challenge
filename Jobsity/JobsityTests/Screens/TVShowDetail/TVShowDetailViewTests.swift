//
//  TVShowDetailViewTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class TVShowDetailViewTests: XCTestCase {

    // MARK: - Properties
    private let sut = TVShowDetailView(model: .init(poster: "",
                                                    days: ["Friday", "Sunday"],
                                                    time: "2PM - 4PM",
                                                    genres: ["Comedy", "Sitcom"],
                                                    summary: "The best TV Show of all time"))
    
    // MARK: - Tests
    func testTVShowDetailViewHasCorrectLayout() {
        let episodes: [TVShowDetailView.Episode] = [
            .init(id: 1, season: 1, number: 1, name: "First Episode", image: ""),
            .init(id: 2, season: 1, number: 2, name: "Second Episode", image: ""),
            .init(id: 3, season: 1, number: 3, name: "Third Episode", image: ""),
            .init(id: 3, season: 2, number: 1, name: "Begin Second season", image: "")
        ]
        sut.setupEpisodes(episodes)
        sut.frame = .init(origin: .zero, size: .init(width: 300, height: 700))
        assertSnapshot(matching: sut, as: .wait(for: 1.0, on: .image))
    }
}
