//
//  ViewController.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 18/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

protocol CharacterListViewControllerDelegate: class {
    func didSelectCharacter(character: Character)
}

class CharacterListViewController: UIViewController {

    weak var layoutDelegate: UICollectionViewDelegateFlowLayout?
    private(set) var viewModel: CharacterListViewModel
    private let prefetchingDataSource: CharacterListViewModelPrefetching
    private let characterListView: CharacterListView

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(delegate: UICollectionViewDelegateFlowLayout, repository: CharacterNetworkRepository) {

        self.layoutDelegate = delegate
        self.prefetchingDataSource = CharacterListViewModelPrefetching(repository: repository)
        self.characterListView = CharacterListView(layoutDelegate: layoutDelegate, prefetchDataSource: self.prefetchingDataSource)

        self.viewModel = CharacterListViewModel(for: self.characterListView, repository: repository)
        super.init(nibName: nil, bundle: nil)
        self.title = "Marvel"
    }

    override func loadView() {
        self.view = characterListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}
