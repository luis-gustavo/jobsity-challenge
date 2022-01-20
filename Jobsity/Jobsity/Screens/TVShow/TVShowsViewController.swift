//
//  TVShowsViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

final class TVShowsViewController: UIViewController {
    
    // MARK: - View Properties
    private let tvShowsView = TVShowsView()
    
    // MARK: - LoadView
    override func loadView() {
        self.view = tvShowsView
    }
}
