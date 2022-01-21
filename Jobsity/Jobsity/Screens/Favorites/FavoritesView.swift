//
//  FavoritesView.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func didSelectTVShow(with id: Int)
    func shouldUnfavorite(tvShowId: Int)
}

final class FavoritesView: UIView {
    
    // MARK: - Properties
    weak var delegate: FavoritesViewDelegate?
    private var tvShows = [TVShowViewModel]()
    
    // MARK: - View Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TVShowCell.self, forCellReuseIdentifier: TVShowCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CodableView extension
extension FavoritesView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews([tableView])
    }
    
    func setupConstraints() {
        tableView.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
    }
    
    func setupAdditionalConfiguration() { }
}

// MARK: - Internal methods
extension FavoritesView {
    func setupTVShows(_ tvShows: [TVShowViewModel]) {
        self.tvShows = tvShows
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension FavoritesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tvShow = tvShows[indexPath.row]
        self.delegate?.didSelectTVShow(with: tvShow.id)
    }
}

// MARK: - UITableViewDelegate
extension FavoritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowCell.identifier, for: indexPath) as? TVShowCell else {
            return UITableViewCell()
        }
        
        let tvShow = tvShows[indexPath.row]
        
        cell.configureWith(name: tvShow.name, image: tvShow.image, isFavorite: true)
        cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .white : .ultraLightGray
        cell.delegate = self
        cell.tag = indexPath.row
        
        return cell
    }
}

// MARK: - TVShowCellDelegate
extension FavoritesView: TVShowCellDelegate {
    func didSelectFavorite(_ sender: TVShowCell, row: Int, shouldFavorite: Bool) {
        let tvShowId = self.tvShows[row].id
        self.delegate?.shouldUnfavorite(tvShowId: tvShowId)
    }
}
