//
//  TVShowsViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

protocol TVShowsViewControllerDelegate: AnyObject {
    func didSelectTVShow(_ tvShow: TVShow)
}

final class TVShowsViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: TVShowsViewControllerDelegate?
    private let provider: TVShowProviderProtocol
    private var tvShows = [TVShow]()
    
    // MARK: - View Properties
    private lazy var tvShowsView: TVShowsView = {
        let view = TVShowsView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(provider: TVShowProviderProtocol) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LoadView
    override func loadView() {
        self.view = tvShowsView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.tvShows.localized
        requestTvShows()
    }
}

// MARK: - TVShowsViewDelegate
extension TVShowsViewController: TVShowsViewDelegate {
    func didSelectTVShow(with id: Int) {
        guard let tvShow = tvShows.first(where: { $0.id == id }) else { return }
        self.delegate?.didSelectTVShow(tvShow)
    }
}

// MARK: - Private methods
private extension TVShowsViewController {
    func requestTvShows() {
        self.provider.requestTVShows { [weak self] result in
            switch result {
                case let .success(tvShows):
                    guard let self = self else { return }
                    self.tvShows = tvShows
                    self.tvShowsView.setupTvShows(tvShows: TVShowsViewControllerFactory.createViewModel(model: tvShows))
                case let .failure(error): print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Factory
fileprivate struct TVShowsViewControllerFactory {
    static func createViewModel(model: [TVShow]) -> [TVShowsView.Model] {
        return model.map({ .init(id: $0.id,
                                 name: $0.name,
                                 image: $0.image.medium) })
    }
}
