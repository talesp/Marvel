//
//  CharacterListView.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharacterListView: UIView {

    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private(set) lazy var emptyView: UIView = {
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Empty data"
        emptyView.addSubview(label)
        emptyView.backgroundColor = .white
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: emptyView.widthAnchor)
            ])
        return emptyView
    }()

    @available(*, unavailable, message: "Use `init(layoutDelegate:prefetchDataSource:)` instead")
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - and should not be called directly")
    }

    init(layoutDelegate delegate: UICollectionViewDelegateFlowLayout?,
         prefetchDataSource: UICollectionViewDataSourcePrefetching?) {

        super.init(frame: .zero)
        collectionView.delegate = delegate
        collectionView.prefetchDataSource = prefetchDataSource
        setupViewConfiguration()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showLoadingIndicator() {
        collectionView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }

    func hideBackgroundView() {
        collectionView.backgroundView = nil
        activityIndicator.stopAnimating()
    }

    func showEmptyView() {
        collectionView.backgroundView = self.emptyView
    }
}

extension CharacterListView: ViewConfiguration {

    func configureViews() {
        collectionView.backgroundColor = .darkGray
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .red
        searchBar.tintColor = .lightText
        searchBar.barTintColor = .darkGray

    }

    func buildViewHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.invalidateLayout()
    }
}
