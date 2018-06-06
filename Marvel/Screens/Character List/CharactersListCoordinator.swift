//
//  CharactersListCoordinator.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharactersListCoordinator: NSObject {

    lazy var repository = CharacterNetworkRepository(pageSize: 20) { a, b in
        fatalError("implement")
    }

    let navigationController: UINavigationController
    var viewModel: CharacterListViewModel?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        viewModel = CharacterListViewModel(repository: repository)
        guard let viewModel = viewModel else { return }
        let rootViewController = CharacterListViewController(viewModel: viewModel, delegate: self)
        navigationController.pushViewController(rootViewController, animated: false)
    }
}

extension CharactersListCoordinator: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = repository.loadedElements[indexPath.item]
        let viewController = CharacterDetailViewController(character: character)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else { return .zero }
        return viewModel.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }

}
