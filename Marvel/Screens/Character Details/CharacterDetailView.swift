//
//  CharacterDetailView.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharacterDetailView: UIView {

    private lazy var titledImageView: TitledImageView = {
        let titledImageView = TitledImageView()
        titledImageView.translatesAutoresizingMaskIntoConstraints = false
        return titledImageView
    }()
    private var titledImageViewModel: TitledImageViewModel?

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
        comicsLabel.numberOfLines = 0
        comicsLabel.textColor = UIColor.lightText
        return comicsLabel
    }()

    private lazy var eventsLabel: UILabel = {
        let eventsLabel = UILabel()
        eventsLabel.translatesAutoresizingMaskIntoConstraints = false
        eventsLabel.numberOfLines = 0
        eventsLabel.textColor = UIColor.lightText
        return eventsLabel
    }()

    private lazy var storiesLabel: UILabel = {
        let storiesLabel = UILabel()
        storiesLabel.translatesAutoresizingMaskIntoConstraints = false
        storiesLabel.numberOfLines = 0
        storiesLabel.textColor = UIColor.lightText
        return storiesLabel
    }()

    private lazy var seriesLabel: UILabel = {
        let seriesLabel = UILabel()
        seriesLabel.translatesAutoresizingMaskIntoConstraints = false
        seriesLabel.numberOfLines = 0
        seriesLabel.textColor = UIColor.lightText
        return seriesLabel
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ titledImageView ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }

    func setup(title: String,
               placeholderImage: UIImage? = nil,
               imageOrURL: Either<UIImage, URL>,
               description: String,
               comics: [ComicModel]? = nil,
               events: [EventModel]? = nil,
               stories: [StoryModel]? = nil,
               series: [SerieModel]? = nil,
               toggleFavoriteCharacter: @escaping ((String) -> Void)) {
        self.titledImageViewModel = TitledImageViewModel(for: self.titledImageView,
                                                         title: title,
                                                         placeholderImage: placeholderImage,
                                                         favorite: false,
                                                         imageOrURL: imageOrURL,
                                                         toggleFavoriteCharacter: toggleFavoriteCharacter)

        if description.isEmpty == false {
            let text = NSMutableAttributedString(string: "Description:\n", attributes: [
                .font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline),
                .foregroundColor: UIColor.white
                ])
            text.append(NSMutableAttributedString(string: "\(description)", attributes: [
                .font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
                ]))
            self.descriptionLabel.attributedText = text
            stackView.addArrangedSubview(self.descriptionLabel)
        }
        if let comics = comics, comics.isEmpty == false {
            self.comicsLabel.attributedText = text(entities: comics, title: "Comics")
            stackView.addArrangedSubview(self.comicsLabel)
        }
        if let events = events, events.isEmpty == false {
            self.eventsLabel.attributedText = text(entities: events, title: "Events")
            stackView.addArrangedSubview(self.eventsLabel)
        }
        if let stories = stories, stories.isEmpty == false {
            self.storiesLabel.attributedText = text(entities: stories, title: "Stories")
            stackView.addArrangedSubview(self.storiesLabel)
        }
        if let series = series, series.isEmpty == false {
            self.seriesLabel.attributedText = text(entities: series, title: "Series")
            stackView.addArrangedSubview(self.seriesLabel)
        }
    }

    private func text(entities: [NamedResourceModel], title: String) -> NSAttributedString {
        let text = NSMutableAttributedString(string: "\(title):\n", attributes: [
            .font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline),
            .foregroundColor: UIColor.white
            ])
        let content = entities.compactMap({ $0.name })
            .prefix(3)
            .map({"\"\($0)\""})
            .joined(separator: ";\n")
        text.append(NSMutableAttributedString(string: "\(content)", attributes: [
            .font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
            ]))
        return text as NSAttributedString
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterDetailView: ViewConfiguration {
    func buildViewHierarchy() {
        scrollView.addSubview(stackView)
        addSubview(scrollView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
            ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            titledImageView
                .leadingAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titledImageView
                .trailingAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
            ])

    }

    func configureViews() {
        backgroundColor = .darkGray
    }
}
