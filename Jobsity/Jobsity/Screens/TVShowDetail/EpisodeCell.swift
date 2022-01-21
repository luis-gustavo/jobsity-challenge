//
//  EpisodeCell.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

final class EpisodeCell: UITableViewCell {
    
    // MARK: - View Properties
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 20
        return imageView
    }()
    
    private let seasonAndNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CodableView extension
extension EpisodeCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubviews([episodeImageView, seasonAndNumberLabel, episodeNameLabel])
    }
    
    func setupConstraints() {
        episodeImageView.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                view.heightAnchor.constraint(equalToConstant: 40),
                view.widthAnchor.constraint(equalToConstant: 40)
            ]
        }
        
        seasonAndNumberLabel.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: 8),
            ]
        }
        
        episodeNameLabel.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: seasonAndNumberLabel.trailingAnchor, constant: 8),
            ]
        }
    }
    
    func setupAdditionalConfiguration() { }
}

// MARK: - Internal methods
extension EpisodeCell {
    func configureWith(name: String, season: Int, number: Int, image: String) {
        self.episodeNameLabel.text = name
        self.seasonAndNumberLabel.text = "\(season)x\(number)"
        self.episodeImageView.downloaded(from: image)
    }
}
