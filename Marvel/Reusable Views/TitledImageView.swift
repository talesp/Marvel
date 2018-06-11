//
//  TitledImageView.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import os.log

class TitledImageView: UIView {

    fileprivate var imageDownloadTask: URLSessionDownloadTask?

    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
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

    override var intrinsicContentSize: CGSize {
        return self.imageView.intrinsicContentSize
    }
}

extension TitledImageView {

    private static let cache = NSCache<NSString, AnyObject>()

    func setup(title: String, placeholderImage: UIImage?, imageURL: URL) {
        self.titleLabel.text = title
        self.imageView.image = placeholderImage

        let activityIndicator = setupActivityIndicator()

        let configuration = URLSessionConfiguration.default

        let path = imageURL.absoluteString as NSString

        if let image = TitledImageView.cache.object(forKey: path) as? UIImage {
            DispatchQueue.main.async { [weak self] in
                UIView.animate(withDuration: 0.3, animations: {
                    self?.imageView.image = image
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                })
            }
        }
        else {
            imageDownloadTask = URLSession(configuration: configuration)
                .downloadTask(with: imageURL, completionHandler: { [weak self] url, urlResponse, error in
                    let image: UIImage
                    if let response = urlResponse as? HTTPURLResponse, response.statusCode == 200, let fileURL = url {
                        image = UIImage(contentsOfFile: fileURL.path) !! "invalid path"
                        TitledImageView.cache.setObject(image, forKey: path)
                    }
                    else {
                        image = UIImage.error
                        if let error = error { dump(error) }
                    }
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.3, animations: {
                            self?.imageView.image = image
                            activityIndicator.stopAnimating()
                            activityIndicator.removeFromSuperview()
                        })
                    }
                })
            imageDownloadTask?.resume()
        }
    }

    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        self.imageView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
            ])
        return activityIndicator
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
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: self.intrinsicContentSize.height / self.intrinsicContentSize.width),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }

    func configureViews() {
        titleLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    }

}
