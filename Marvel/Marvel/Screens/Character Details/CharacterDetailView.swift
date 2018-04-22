//
//  CharacterDetailView.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class CharacterDetailView: UIView {

    var viewModel: CharacterDetailViewModel

    init(frame: CGRect, viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterDetailView: ViewConfiguration {
    func buildViewHierarchy() {
        //<#code#>
    }

    func setupConstraints() {
        //<#code#>
    }

}
