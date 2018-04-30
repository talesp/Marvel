//
//  CharacterListView.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharacterListView: UIView {

    let viewModel: CharacterListViewModel

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    @available(*, unavailable, message: "Use `init(viewModel:delegate:)` instead")
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - and should not be called directly")
    }

    init(viewModel: CharacterListViewModel,
         layoutDelegate delegate: UICollectionViewDelegateFlowLayout?,
         prefetchDataSource: UICollectionViewDataSourcePrefetching?) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        collectionView.dataSource = viewModel
        collectionView.delegate = delegate
        setupViewConfiguration()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CharacterListView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor),
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }

}
