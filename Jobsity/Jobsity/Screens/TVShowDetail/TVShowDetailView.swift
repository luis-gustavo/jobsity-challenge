//
//  TVShowDetailView.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

final class TVShowDetailView: UIView {
    
    // MARK: - Model
    struct Model {
        let poster: String
        let days: [String]
        let time: String
        let genres: [String]
        let summary: String
    }
    
    // MARK: - Episode
    struct Episode {
        let id: Int
        let season: Int
        let number: Int
        let name: String
        let image: String
    }
    
    // MARK: - Properties
    private let model: Model
    private var episodes = [Episode]()
    
    // MARK: - View Properties
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.downloaded(from: model.poster)
        imageView.cornerRadius = 8
        return imageView
    }()
    
    private lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString()
            .bold("\(Localizable.schedule.localized): ")
            .normal("\(model.days.joined(separator: ", "))(\(model.time))")
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString()
            .bold("\(Localizable.genres.localized): ")
            .normal("\(model.genres.joined(separator: " | "))")
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString()
            .bold("\(Localizable.summary.localized): ").normal("\(model.summary)")
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.cornerRadius = 8
        stackView.spacing = 4
        stackView.backgroundColor = .white
//        stackView.layer.shadowOffset = .init(width: 0, height: 3)
//        stackView.layer.shadowRadius = 4
//        stackView.layer.masksToBounds = false
//        stackView.layer.shadowColor = UIColor.gray.cgColor
//        stackView.layer.shadowOpacity = 1
        return stackView
    }()
    
    private lazy var episodesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "\(Localizable.episodes.localized):"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
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
extension TVShowDetailView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews([scrollView])
        scrollView.addSubviews([containerView])
        containerView.addSubviews([posterImageView, verticalStackView, episodesLabel, tableView])
        verticalStackView.addArrangedSubviews([genresLabel, scheduleLabel, summaryLabel])
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
        
        verticalStackView.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                view.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            ]
        }
        
        episodesLabel.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                view.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            ]
        }
        
        tableView.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                view.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 8),
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
extension TVShowDetailView {
    func setupEpisodes(_ episodes: [TVShowDetailView.Episode]) {
        self.episodes = episodes
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension TVShowDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SEASON \(section + 1)"
    }
}

// MARK: - UITableViewDataSource
extension TVShowDetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (episodes.map({ $0.season }).sorted(by: { $0 > $1 }).first ?? 1) - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let episodesOfSection = episodes.filter({ ($0.season - 1) == section }).count
        return episodesOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as? EpisodeCell else {
            return UITableViewCell()
        }
        
        let episodesOfSection = episodes.filter({ ($0.season - 1) == indexPath.section })
        let episode = episodesOfSection[indexPath.row]
        
        cell.configureWith(name: episode.name,
                           season: episode.season,
                           number: episode.number,
                           image: episode.image)
        cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .white : .ultraLightGray
        
        return cell
    }
}
