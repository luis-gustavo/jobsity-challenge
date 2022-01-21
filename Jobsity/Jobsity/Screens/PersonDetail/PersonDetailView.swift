//
//  PersonDetailView.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import UIKit

protocol PersonDetailViewDelegate: AnyObject {
    func didSelectTVShow(with id: Int)
    func didSelectFavorite(tvShowId: Int, shouldFavorite: Bool)
}

final class PersonDetailView: UIView {
    
    // MARK: - Model
    struct Model {
        let image: String
    }
    
    // MARK: - View Properties
    private let model: Model
    weak var delegate: PersonDetailViewDelegate?
    private var tvShows = [TVShowViewModel]()
    private var favoriteTVShows = [TVShowViewModel]()
    
    // MARK: - View Properties
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = true
        return view
    }()
    
    private let containerView = UIView()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.downloaded(from: model.image)
        imageView.cornerRadius = 8
        return imageView
    }()
    
    private lazy var tvShowsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "\(Localizable.tvShows.localized):"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(TVShowCell.self, forCellReuseIdentifier: TVShowCell.identifier)
        return tableView
    }()
    
    // MARK: - Inits
    init(model: Model) {
        self.model = model
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CodableView extension
extension PersonDetailView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews([scrollView])
        scrollView.addSubviews([containerView])
        containerView.addSubviews([posterImageView, tvShowsLabel, tableView])
    }
    
    func setupConstraints() {
        scrollView.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
        
        containerView.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
        
        posterImageView.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                view.heightAnchor.constraint(equalToConstant: 200)
            ]
        }
        
        tvShowsLabel.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                view.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            ]
        }
        
        tableView.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                view.topAnchor.constraint(equalTo: tvShowsLabel.bottomAnchor, constant: 8),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.size.height * 0.75)
            ]
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

// MARK: - Internal methods
extension PersonDetailView {
    func setupTVShows(_ tvShows: [TVShowViewModel]) {
        self.tvShows = tvShows
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
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
extension PersonDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tvShow = tvShows[indexPath.row]
        self.delegate?.didSelectTVShow(with: tvShow.id)
    }
}

// MARK: - UITableViewDataSource
extension PersonDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowCell.identifier, for: indexPath) as? TVShowCell else {
            return UITableViewCell()
        }
        
        let tvShow = tvShows[indexPath.row]
        
        cell.configureWith(name: tvShow.name, image: tvShow.image, isFavorite: tvShowIsFavorite(tvShow))
        cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .white : .ultraLightGray
        cell.delegate = self
        cell.tag = indexPath.row
        
        return cell
    }
}

// MARK: - TVShowCellDelegate
extension PersonDetailView: TVShowCellDelegate {
    func didSelectFavorite(_ sender: TVShowCell, row: Int, shouldFavorite: Bool) {
        let tvShowId = self.tvShows[row].id
        self.delegate?.didSelectFavorite(tvShowId: tvShowId, shouldFavorite: shouldFavorite)
    }
}

// MARK: - Private methods
private extension PersonDetailView {
    func tvShowIsFavorite(_ tvShow: TVShowViewModel) -> Bool {
        return self.favoriteTVShows.contains(where: { $0.id == tvShow.id })
    }
}
