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

    let characters: CharactersMemoryRepository
    
    private var observation: NSKeyValueObservation?

    weak var collectionView: UICollectionView?

    init(characters: CharactersMemoryRepository) {
        self.characters = characters
        super.init()
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
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionView = collectionView
        let cell: TitledImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let character = self.characters.all[indexPath.item]
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
    private let repository: CharactersMemoryRepository

    init(repository: CharactersMemoryRepository) {
        self.repository = repository
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // <#code#>
    }

}
