//
//  EpisodeDetailView.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import UIKit

final class EpisodeDetailView: UIView {
    
    // MARK: - Model
    struct Model {
        let season: Int
        let number: Int
        let summary: String
        let poster: String
    }
    
    // MARK: - Properties
    private let model: Model
    
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
        imageView.downloaded(from: model.poster)
        imageView.cornerRadius = 8
        return imageView
    }()
    
    private lazy var seasonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString()
            .bold("\(Localizable.season.localized): ")
            .normal("\(model.season)")
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString()
            .bold("\(Localizable.episode.localized): ")
            .normal("\(model.number)")
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString()
            .bold("\(Localizable.summary.localized): ")
            .normal("\(model.summary)")
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.cornerRadius = 8
        stackView.spacing = 4
        stackView.backgroundColor = .white
        return stackView
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
extension EpisodeDetailView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews([scrollView])
        scrollView.addSubviews([containerView])
        containerView.addSubviews([posterImageView, verticalStackView])
        verticalStackView.addArrangedSubviews([seasonLabel, numberLabel, summaryLabel])
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
                view.topAnchor.constraint(equalTo: containerView.topAnchor),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                view.heightAnchor.constraint(equalToConstant: 200)
            ]
        }
        
        verticalStackView.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                view.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            ]
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
