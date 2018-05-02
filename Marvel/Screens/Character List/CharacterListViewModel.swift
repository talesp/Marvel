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

    let repository: CharacterMemoryRepository
    
    private var observation: NSKeyValueObservation?

    weak var collectionView: UICollectionView?

    init(repository: CharacterMemoryRepository) {
        self.repository = repository
        super.init()
        self.repository.items(pageIndex: 0) { [weak self] characters in
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
        return repository.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionView = collectionView
        let cell: TitledImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let character = self.repository.loadedElements[indexPath.item]
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
    private let repository: CharacterMemoryRepository

    init(repository: CharacterMemoryRepository) {
        self.repository = repository
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        self.repository.items(pageIndex: 0) { characters in
            dump(characters)
        }
    }

}
