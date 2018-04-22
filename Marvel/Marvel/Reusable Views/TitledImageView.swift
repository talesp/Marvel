//
//  TitledImageView.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TitledImageView: UIView {

    fileprivate var imageDownloadTask: URLSessionDownloadTask?

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(image: UIImage, title: String) {
        self.imageView.image = image
        self.titleLabel.text = title
    }
}

extension TitledImageView {

    func setup(title: String, imageURL: URL) {
        self.titleLabel.text = title
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.startAnimating()
        self.imageView.addSubview(activityIndicator)
        activityIndicator.center = imageView.center

        imageDownloadTask?.cancel()
        let configuration = URLSessionConfiguration.default
        imageDownloadTask = URLSession(configuration: configuration)
            .downloadTask(with: imageURL, completionHandler: { [weak self] url, urlResponse, error in
                if let response = urlResponse as? HTTPURLResponse,
                    response.statusCode == 200,
                    let fileURL = url {
                    self?.imageView.image = UIImage(contentsOfFile: fileURL.path)
                }
                else if let error = error {
                    self?.imageView.image = UIImage(named: "errorImage")
                    dump(error)
                }

                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        })
    }

    func cancelImageDownload() {
        imageDownloadTask?.cancel()
        imageDownloadTask = nil
    }
}

extension TitledImageView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    func setupConstraints() {
        //TODO: instrinsic content size
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }

    func configureViews() {
        titleLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
    }
}
