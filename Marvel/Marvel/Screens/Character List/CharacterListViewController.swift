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

    private lazy var characterListView: CharacterListView = {
        let view = CharacterListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
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
