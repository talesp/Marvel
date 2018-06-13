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

    var isFavorite = false {
        didSet {
            if isFavorite {
                button.setImage(UIImage(named: "favorite"), for: .normal)
            }
            else {
                button.setImage(UIImage(named: "unfavorite"), for: .normal)
            }
        }
    }
    
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

    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleFavorite(semder:)), for: .touchUpInside)
        return button
    }()

    var toggleFavorite: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return self.imageView.intrinsicContentSize
    }

    @objc func toggleFavorite(semder: UIButton) {
        self.isFavorite = !self.isFavorite
        self.toggleFavorite?()
    }
}

extension TitledImageView {

    private static let cache = NSCache<NSString, AnyObject>()

    func setup(image: UIImage, title: String) {
        UIView.animate(withDuration: 0.2) {
            self.imageView.image = image
            self.titleLabel.text = title
        }
    }

    func setup(title: String, placeholderImage: UIImage?, imageURL: URL) {
        self.titleLabel.text = title
        UIView.transition(with: self.imageView,
                          duration: 0.2,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.imageView.image = placeholderImage
        })

        let activityIndicator = setupActivityIndicator()

        let configuration = URLSessionConfiguration.default

        let path = imageURL.absoluteString as NSString

        if let image = TitledImageView.cache.object(forKey: path) as? UIImage {
            DispatchQueue.main.async { [weak self] in
                guard let imageView = self?.imageView else { return }
                UIView.transition(with: imageView,
                                  duration: 0.2,
                                  options: [.transitionCrossDissolve],
                                  animations: {
                                    self?.imageView.image = image
                }, completion: { _ in
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
                        guard let imageView = self?.imageView else { return }
                        UIView.transition(with: imageView,
                                          duration: 0.2,
                                          options: [.transitionCrossDissolve],
                                          animations: {
                                            self?.imageView.image = image
                        }, completion: { _ in
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
        addSubview(button)
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
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            button.widthAnchor.constraint(equalToConstant: 32),
            button.heightAnchor.constraint(equalToConstant: 32)
            ])
    }

    func configureViews() {
        titleLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        button.setImage(UIImage(named: "unfavorite"), for: .normal)
        button.setBackgroundImage(UIColor.lightGray.withAlphaComponent(0.9).image, for: .normal)
        button.layer.cornerRadius = 4.0
        button.layer.borderColor = UIColor.lightText.cgColor
        button.clipsToBounds = true
    }

}
