//
//  TVShowsView.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

protocol TVShowsViewDelegate: AnyObject {
    func didSelectTVShow(with id: Int)
    func didSelectPerson(with id: Int)
    func didSelectFavorite(tvShowId: Int, shouldFavorite: Bool)
    func fetchTVShows()
}

final class TVShowsView: UIView {
    
    // MARK: - Properties
    var isShowingTVShows = true
    weak var delegate: TVShowsViewDelegate?
    private var tvShows = [TVShowViewModel]()
    private var favoriteTVShows = [TVShowViewModel]()
    private var people = [PersonViewModel]()
    
    // MARK: - View Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.identifier)
        tableView.register(TVShowCell.self, forCellReuseIdentifier: TVShowCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.prefetchDataSource = self
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
extension TVShowsView: ViewCodable {
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
extension TVShowsView {
    
    func setupPeople(_ people: [PersonViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.people = people
            self.tableView.reloadData()
        }
    }
    
    func setupTVShows(_ tvShows: [TVShowViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tvShows = tvShows
            self.tableView.reloadData()
        }
    }
    
    func appendTVShows(_ tvShows: [TVShowViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let oldCount = self.tvShows.count
            self.tvShows.append(contentsOf: tvShows)
            let newCount = self.tvShows.count
            let indexPaths = (oldCount..<newCount).map({ IndexPath(row: $0, section: 0) })
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func setupFavoriteTVShows(_ tvShows: [TVShowViewModel]) {
        self.favoriteTVShows = tvShows
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension TVShowsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowingTVShows {
            let tvShow = tvShows[indexPath.row]
            self.delegate?.didSelectTVShow(with: tvShow.id)
        } else {
            let person = people[indexPath.row]
            self.delegate?.didSelectPerson(with: person.id)
        }
    }
}

// MARK: - UITableViewDelegate
extension TVShowsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowingTVShows ? tvShows.count : people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowingTVShows {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowCell.identifier, for: indexPath) as? TVShowCell else {
                return UITableViewCell()
            }
            
            let tvShow = tvShows[indexPath.row]
            
            cell.configureWith(name: tvShow.name, image: tvShow.image, isFavorite: tvShowIsFavorite(tvShow))
            cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .white : .ultraLightGray
            cell.delegate = self
            cell.tag = indexPath.row
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.identifier, for: indexPath) as? PersonCell else {
                return UITableViewCell()
            }
            
            let person = people[indexPath.row]
            
            cell.configureWith(name: person.name, image: person.image)
            cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .white : .ultraLightGray
            return cell
        }
    }
}

// MARK: - TVShowCellDelegate
extension TVShowsView: TVShowCellDelegate {
    func didSelectFavorite(_ sender: TVShowCell, row: Int, shouldFavorite: Bool) {
        let tvShowId = self.tvShows[row].id
        self.delegate?.didSelectFavorite(tvShowId: tvShowId, shouldFavorite: shouldFavorite)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension TVShowsView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isOnLastRow) {
            self.delegate?.fetchTVShows()
        }
    }
}

// MARK: - Private methods
private extension TVShowsView {
    func isOnLastRow(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= (self.tvShows.count - 1)
    }
    
    func tvShowIsFavorite(_ tvShow: TVShowViewModel) -> Bool {
        return self.favoriteTVShows.contains(where: { $0.id == tvShow.id })
    }
}
