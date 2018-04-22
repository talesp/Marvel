//
//  CharactersListCoordinator.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharactersListCoordinator: NSObject {

    let characterRepository = CharactersMemoryRepository()

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = CharacterListViewModel(characters: characterRepository)
        let rootViewController = CharacterListViewController(viewModel: viewModel, delegate: self)
        navigationController.pushViewController(rootViewController, animated: false)
    }
}

extension CharactersListCoordinator: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characterRepository.all[indexPath.item]
        let viewController = CharacterDetailViewController(character: character)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = collectionView.bounds.size.width / numberOfCells
        return CGSize(width: width, height: width)
    }

}
