//
//  TVShowsViewTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class TVShowsViewTests: XCTestCase {

    // MARK: - Properties
    private let sut = TVShowsView()
    
    // MARK: - Tests
    func testTVShowsViewHasCorrectLayout() {
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
        assertSnapshot(matching: sut, as: .wait(for: 1.0, on: .image))
    }
}
