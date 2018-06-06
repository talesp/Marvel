//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 22/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

/// `NSObject` mandatory for key value observation
class CharacterListViewModel: NSObject {

    weak var repository: CharacterNetworkRepository?
    weak var collectionView: UICollectionView?

    private var observation: NSKeyValueObservation?

    init(repository: CharacterNetworkRepository) {
        self.repository = repository
        super.init()
        self.repository?.items(pageIndex: 0) { [weak self] characters in
            self?.collectionView?.reloadData()
        }
    }

    deinit {
        observation?.invalidate()
    }
}

extension CharacterListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.collectionView == nil {
            self.collectionView = collectionView
            self.collectionView?.registerCell(cellType: TitledImageCollectionViewCell.self)
        }
        return self.repository?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionView = collectionView
        let cell: TitledImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let character = self.repository?.loadedElements[indexPath.item] else { return cell }

        if let url = character.thumbnailURL, let name = character.name {
            cell.viewModel = TitledImageViewModel(title: name,
                                                  placeholderImage: nil,
                                                  imageOrURL: Either<UIImage, URL>.right(url))
        }
        return cell
    }

}

extension CharacterListViewModel: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = collectionView.bounds.size.width / numberOfCells
        return CGSize(width: width, height: width)
    }

}

class CharacterListViewModelPrefetching: NSObject, UICollectionViewDataSourcePrefetching {
    private weak var repository: CharacterNetworkRepository?

    init(repository: CharacterNetworkRepository) {
        self.repository = repository
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        guard let repository = self.repository,
            let maxIndex = indexPaths.max(by: { $0.row > $1.row })?.row else { return }

        let page = maxIndex % repository.pageSize

        repository.items(pageIndex: page) { characters in
            dump(characters)
            collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        }
    }

}
