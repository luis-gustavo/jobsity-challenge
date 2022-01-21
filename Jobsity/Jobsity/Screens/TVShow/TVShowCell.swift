//
//  TVShowCell.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

protocol TVShowCellDelegate: AnyObject {
    func didSelectFavorite(_ sender: TVShowCell, row: Int, shouldFavorite: Bool)
}

final class TVShowCell: UITableViewCell {
    
    // MARK: - View Properties
    weak var delegate: TVShowCellDelegate?
    private let starUnfilledName = "star"
    private let starFilledName = "star.fill"
    
    private let tvShowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 20
        return imageView
    }()
    
    private let tvShowNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var starButton: UIButton = {
        let starButton = UIButton()
        starButton.setImage(.init(systemName: starUnfilledName), for: .normal)
        starButton.addTarget(self, action: #selector(didTouchFavorite), for: .touchUpInside)
        starButton.isSelected = false
        return starButton
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
extension TVShowCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubviews([tvShowImageView, tvShowNameLabel, starButton])
    }
    
    func setupConstraints() {
        tvShowImageView.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                view.heightAnchor.constraint(equalToConstant: 40),
                view.widthAnchor.constraint(equalToConstant: 40)
            ]
        }
        
        tvShowNameLabel.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: tvShowImageView.trailingAnchor, constant: 8),
                view.trailingAnchor.constraint(equalTo: starButton.leadingAnchor, constant: -8)
            ]
        }
        
        starButton.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                view.heightAnchor.constraint(equalToConstant: 22),
                view.widthAnchor.constraint(equalToConstant: 22)
            ]
        }
    }
    
    func setupAdditionalConfiguration() { }
}

// MARK: - Internal methods
extension TVShowCell {
    func configureWith(name: String, image: String, isFavorite: Bool) {
        self.tvShowNameLabel.text = name
        self.tvShowImageView.downloaded(from: image)
        self.starButton.setImage(.init(systemName: isFavorite ? starFilledName : starUnfilledName), for: .normal)
        self.starButton.isSelected = isFavorite
    }
}

// MARK: - Targets extension
private extension TVShowCell {
    @objc
    func didTouchFavorite() {
        self.delegate?.didSelectFavorite(self, row: tag, shouldFavorite: !starButton.isSelected)
    }
}
