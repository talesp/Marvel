//
//  CharactersListCoordinator.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharactersListCoordinator: NSObject {

    private var viewController: UIViewController?

    lazy var repository = CharacterNetworkRepository(pageSize: 20) { result, _ in
        switch result {
        case .success(let data):
            print(String(describing: type(of: data)))
        case .failure(let error):
            fatalError("\(error)")
        }

    }

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let rootViewController = CharacterListViewController(delegate: self,
                                                             repository: self.repository)
        self.viewController = rootViewController
        navigationController.pushViewController(rootViewController, animated: false)
    }
}

extension CharactersListCoordinator: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let characterListViewController = self.viewController as? CharacterListViewController !! "wrong view controller"
        let character: Character
        if let searchResult = characterListViewController.viewModel.searchResult {
            guard let internalCharacter = searchResult[indexPath.item] else {
                fatalError("invalid index path")
            }
            character = internalCharacter
        }
        else {
            guard let internalCharacter = characterListViewController.viewModel.repository?[indexPath.item] else {
                fatalError("invalid repository or index path")
            }
            character = internalCharacter
        }

        let viewController = CharacterDetailViewController(character: character)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let viewController = self.viewController as? CharacterListViewController else { return CGSize.zero }
        return viewController.viewModel.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }

}
