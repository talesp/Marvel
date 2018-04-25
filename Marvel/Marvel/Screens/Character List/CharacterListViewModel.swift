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

    @objc dynamic let characters: CharactersMemoryRepository
    private var observation: NSKeyValueObservation?

    weak var collectionView: UICollectionView?

    init(characters: CharactersMemoryRepository) {
        self.characters = characters
        defer {
            observation = observe(\.characters.all, options: [.new, .old]) { [weak self] (characters, change) in
                DispatchQueue.main.async {
                    dump(change)
                    dump(characters)
                    guard let indexPaths = self?.collectionView?.indexPathsForVisibleItems, indexPaths.count > 0 else {
                        self?.collectionView?.reloadData()
                        return
                    }
                    self?.collectionView?.reloadItems(at: indexPaths)
                }
            }
        }
        defer {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { [weak self] in
                self?.collectionView?.reloadData()
            }
        }
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
        let character = self.characters.all[indexPath.item]
        if let url = character.thumbnail {
            cell.viewModel = TitledImageViewModel(title: character.name,
                                                  placeholderImage: nil,
                                                  imageOrURL: Either<UIImage, URL>.right(url))
        }
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
