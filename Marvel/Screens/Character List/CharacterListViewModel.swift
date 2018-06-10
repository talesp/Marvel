//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 22/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import os.log

enum ViewState<T> {
    case loading
    case content(T)
    case empty
    case error
}

/// `NSObject` mandatory for key value observation
class CharacterListViewModel: NSObject {

    private(set) weak var repository: CharacterNetworkRepository?
    private(set) weak var collectionView: UICollectionView?
    private(set) weak var view: CharacterListView?

    private var state: ViewState<[Character?]> {
        didSet {
            switch state {
            case .loading:
                self.view?.showLoadingIndicator()
            case let .content(characters):
                os_log("number of characters: %{public}d", characters.count)
                DispatchQueue.main.async {
                    self.view?.hideBackgroundView()
                    self.collectionView?.reloadData()
                }
            case .empty:
                self.view?.showEmptyView()
            case .error:
                self.view?.hideBackgroundView()
            }
        }
    }

    private var observation: NSKeyValueObservation?

    init(for view: CharacterListView, repository: CharacterNetworkRepository) {

        self.view = view
        self.repository = repository
        self.collectionView = view.collectionView
        self.state = .loading

        super.init()
        
        self.collectionView?.dataSource = self
        self.collectionView?.registerCell(cellType: TitledImageCollectionViewCell.self)
        self.repository?.items(pageIndex: 0) { [weak self] result in
            switch result {
            case let .success(characters):
                self?.state = .content(characters)
            case let .failure(error):
                os_log("ERROR: [%{public}d]", error.localizedDescription)
            }
        }
        self.repository?.updatedData = { [weak self] result, page in
            switch result {
            case let .success(characters):
                self?.state = .content(characters)
            case let .failure(error):
                os_log("ERROR: [%{public}d]", error.localizedDescription)
                self?.state = .error
            }
        }
    }

    deinit {
        observation?.invalidate()
    }
}

extension CharacterListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.repository?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionView = collectionView
        let cell: TitledImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let character = self.repository?[indexPath.item] else { return cell }

//        os_log("[ %{public}@ : L %{public}d ]: IndexPaths: %{public}@",
//               log: .default,
//               type: .debug, #function, #line, String(describing: indexPath))
        if let url = character.thumbnailURL, let name = character.name {
            cell.viewModel = TitledImageViewModel(title: name,
                                                  placeholderImage: nil,
                                                  imageOrURL: Either<UIImage, URL>.right(url))
        }
        return cell
    }

}

extension CharacterListViewModel: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = collectionView.bounds.size.width / numberOfCells
        return CGSize(width: width, height: width)
    }

}
