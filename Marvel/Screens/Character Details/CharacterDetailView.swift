//
//  CharacterDetailView.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharacterDetailView: UIView {

    var viewModel: CharacterDetailViewModel

    private lazy var titledImageView: TitledImageView = {
        let titledImageView = TitledImageView()
        titledImageView.translatesAutoresizingMaskIntoConstraints = false
        return titledImageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.lightText
        return descriptionLabel
    }()

    private lazy var comicsLabel: UILabel = {
        let comicsLabel = UILabel()
        comicsLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsLabel.numberOfLines = 2
        comicsLabel.textColor = UIColor.lightText
        return comicsLabel
    }()

    private lazy var eventsLabel: UILabel = {
        let eventsLabel = UILabel()
        eventsLabel.translatesAutoresizingMaskIntoConstraints = false
        eventsLabel.numberOfLines = 2
        eventsLabel.textColor = UIColor.lightText
        return eventsLabel
    }()

    private lazy var storiesLabel: UILabel = {
        let storiesLabel = UILabel()
        storiesLabel.translatesAutoresizingMaskIntoConstraints = false
        storiesLabel.numberOfLines = 2
        storiesLabel.textColor = UIColor.lightText
        return storiesLabel
    }()

    private lazy var seriesLabel: UILabel = {
        let seriesLabel = UILabel()
        seriesLabel.translatesAutoresizingMaskIntoConstraints = false
        seriesLabel.numberOfLines = 2
        seriesLabel.textColor = UIColor.lightText
        return seriesLabel
    }()

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titledImageView, descriptionLabel, comicsLabel, eventsLabel, storiesLabel, seriesLabel
            ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4.0
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViewConfiguration()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterDetailView: ViewConfiguration {
    func buildViewHierarchy() {
        containerView.addSubview(stackView)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
            ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            //TODO:
            titledImageView.widthAnchor.constraint(equalTo: titledImageView.heightAnchor),
            titledImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -8)
            ])
    }

    func configureViews() {
    }
}
