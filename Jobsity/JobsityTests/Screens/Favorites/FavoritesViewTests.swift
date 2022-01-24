//
//  FavoritesViewTests.swift
//  JobsityTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/01/22.
//

import SnapshotTesting
import XCTest
@testable import Jobsity

final class FavoritesViewTests: XCTestCase {

    // MARK: - Properties
    private let sut = FavoritesView()
    
    
    // MARK: - Tests
    func testFavoriteViewHasCorrectLayout() {
        sut.setupTVShows([
            .init(id: 1, name: "House", image: ""),
            .init(id: 2, name: "Breaking Bad", image: ""),
            .init(id: 2, name: "Stranger Things", image: ""),
        ])
        
        sut.frame = .init(origin: .zero, size: .init(width: 300, height: 700))
        
        assertSnapshot(matching: sut, as: .image)
    }
}
