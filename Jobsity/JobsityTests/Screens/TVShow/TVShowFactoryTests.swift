//
//  TVShowFactoryTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import XCTest
@testable import Jobsity

final class TVShowFactoryTests: XCTestCase {

    // MARK: - Tests
    func testCreateViewModelCorrectly() {
        let tvShows: [TVShow] = [
            .init(id: 1,
                  name: "House",
                  image: .init(medium: "medium", original: "original"),
                  genres: [],
                  summary: "Great summary",
                  schedule: .init(time: "8AM", days: ["Friday"])),
            .init(id: 2,
                  name: "Vikings",
                  image: .init(medium: "medium", original: "original"),
                  genres: [],
                  summary: "Great plot",
                  schedule: .init(time: "8AM", days: ["Friday"])),
        ]
        
        let viewModel = TVShowFactory.createViewModel(model: tvShows)
        
        XCTAssertEqual(viewModel.count, tvShows.count)
        XCTAssertEqual(viewModel[0].id, 1)
        XCTAssertEqual(viewModel[0].name, "House")
        XCTAssertEqual(viewModel[0].image, "medium")
        XCTAssertEqual(viewModel[1].id, 2)
        XCTAssertEqual(viewModel[1].name, "Vikings")
        XCTAssertEqual(viewModel[1].image, "medium")
    }
}
