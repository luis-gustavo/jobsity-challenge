//
//  PersonDetailViewTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class PersonDetailViewTests: XCTestCase {

    // MARK: - Properties
    private let sut = PersonDetailView(model: .init(image: ""))

    // MARK: - Tests
    func testPersonDetailViewHasCorrectLayout() {
        let tvShows: [TVShowViewModel] = [
            .init(id: 1, name: "House", image: ""),
            .init(id: 2, name: "House of Cards", image: ""),
            .init(id: 3, name: "Breaking Bad", image: "")
        ]
        let favoriteTVShows: [TVShowViewModel] = [
            .init(id: 1, name: "House", image: "")
        ]
        sut.setupTVShows(tvShows)
        sut.setupFavoriteTVShows(favoriteTVShows)
        
        sut.frame = .init(origin: .zero, size: .init(width: 300, height: 700))
        assertSnapshot(matching: sut, as: .image)
    }
}

