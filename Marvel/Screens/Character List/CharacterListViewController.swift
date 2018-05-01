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

    let viewModel: CharacterListViewModel

    weak var layoutDelegate: UICollectionViewDelegateFlowLayout?

    private lazy var characterListView = CharacterListView(viewModel: viewModel,
                                                           layoutDelegate: layoutDelegate,
                                                           prefetchDataSource: CharacterListViewModelPrefetching(repository: self.viewModel.repository)) //swiftlint:disable:this line_length

    init(viewModel: CharacterListViewModel, delegate: UICollectionViewDelegateFlowLayout) {
        self.viewModel = viewModel
        self.layoutDelegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.title = "Marvel"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = characterListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}
