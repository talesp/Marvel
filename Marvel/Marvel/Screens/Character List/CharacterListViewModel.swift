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

extension CharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let url = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg") !! "PAN!"
        cell.viewModel = TitledImageViewModel(title: "fulano", placeholderImage: nil, imageOrURL: Either<UIImage, URL>.right(url))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = collectionView.bounds.size.width / numberOfCells
        return CGSize(width: width, height: width)
    }

}
