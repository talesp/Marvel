//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    private let character: Character
    lazy var viewModel = CharacterDetailViewModel(model: self.character)

    private lazy var characterDetailView = CharacterDetailView(frame: .zero, viewModel: viewModel)

    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
        self.title = character.name
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = characterDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
