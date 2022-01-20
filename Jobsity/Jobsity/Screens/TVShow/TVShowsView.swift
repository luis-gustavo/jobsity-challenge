//
//  TVShowsView.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

final class TVShowsView: UIView {
    
    // MARK: - Model
    struct Model {
        let id: Int
        let name: String
        let image: String
    }
    
    // MARK: - Properties
    private var model = [Model]()
    
    // MARK: - View Properties
//    private lazy var searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.cornerRadius = 20
//        searchBar.searchTextField.font = .systemFont(ofSize: 16, weight: .regular)
//        searchBar.delegate = self
//        return searchBar
//    }()
    
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
extension TVShowsView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews([/*searchBar, */tableView])
    }
    
    func setupConstraints() {
//        searchBar.setupConstraints { view in
//            [
//                view.topAnchor.constraint(equalTo: topAnchor),
//                view.leadingAnchor.constraint(equalTo: leadingAnchor),
//                view.trailingAnchor.constraint(equalTo: trailingAnchor),
//                view.heightAnchor.constraint(equalToConstant: 40),
//            ]
//        }
        
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
    func setupTvShows(tvShows: [Model]) {
        self.model = tvShows
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension TVShowsView: UITableViewDelegate { }

// MARK: - UITableViewDelegate
extension TVShowsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowCell.identifier, for: indexPath) as? TVShowCell else {
            return UITableViewCell()
        }
        
        let tvShow = model[indexPath.row]
        
        cell.configureWith(name: tvShow.name, image: tvShow.image)
        cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .white : .ultraLightGray
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension TVShowsView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
}
