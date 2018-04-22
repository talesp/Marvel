//
//  CharacterListView.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharacterListView: UIView {

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    @available(*, unavailable)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    init(frame: CGRect, datasource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        super.init(frame: frame)
        setupViewConfiguration()
        collectionView.dataSource = datasource
        collectionView.delegate = delegate
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
