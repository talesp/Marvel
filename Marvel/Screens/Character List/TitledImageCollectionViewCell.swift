//
//  TitledImageCollectionViewCell.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TitledImageCollectionViewCell: UICollectionViewCell, Reusable {

    private lazy var titledImageView: TitledImageView = {
        let view = TitledImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) var viewModel: TitledImageViewModel?

    func setup(title: String, placeholderImage: UIImage? = nil, imageOrURL: Either<UIImage, URL>) {
        self.viewModel = TitledImageViewModel(for: self.titledImageView,
                                              title: title,
                                              placeholderImage: placeholderImage,
                                              imageOrURL: imageOrURL)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitledImageCollectionViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(titledImageView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titledImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titledImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            titledImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titledImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }

    func configureViews() {
        contentView.backgroundColor = .darkGray
    }
}
