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

    private var viewModel: CharacterDetailViewModel?
    private lazy var characterDetailView = CharacterDetailView()

    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
        self.viewModel = CharacterDetailViewModel(for: self.characterDetailView, model: self.character)
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
