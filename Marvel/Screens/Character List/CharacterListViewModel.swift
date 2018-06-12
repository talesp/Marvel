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
    private var searchResult: [Character?]? {
        didSet {
            if let result = searchResult {
                if result.isEmpty {
                    self.state = .empty
                }
                else {
                    self.state = .content(result)
                }
            }
            else {
                guard let loadedElements = repository?.loadedElements else {
                    self.state = .empty
                    return
                }
                self.state = .content(loadedElements)
            }
        }
    }

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

    init(for view: CharacterListView, repository: CharacterNetworkRepository) {

        self.view = view
        self.repository = repository
        self.collectionView = view.collectionView
        self.state = .loading

        super.init()
        
        self.collectionView?.dataSource = self
        self.view?.searchBar.delegate = self
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

}

extension CharacterListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResult?.count ?? self.repository?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: TitledImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let character: Character
        if let searchResult = self.searchResult {
            guard let internalCharacter = searchResult[indexPath.item] else {
                cell.setupLoadingContent()
                return cell
            }
            character = internalCharacter
        }
        else {
            guard let internalCharacter = self.repository?[indexPath.item] else {
                cell.setupLoadingContent()
                return cell
            }
            character = internalCharacter
        }

        if let url = character.thumbnailURL, let name = character.name {
            cell.setup(title: name,
                       placeholderImage: UIImage.loading,
                       imageOrURL: Either<UIImage, URL>.right(url))
        }
        return cell
    }

}

extension CharacterListViewModel: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells: CGFloat
        if collectionView.traitCollection.horizontalSizeClass == .compact {
            numberOfCells = 2
        }
        else {
            numberOfCells = 3
        }

        let minimumInteritemSpacing = (collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
        let width = (collectionView.bounds.size.width - numberOfCells * minimumInteritemSpacing) / numberOfCells
        return CGSize(width: width, height: width)
    }

}

extension CharacterListViewModel: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        os_log("(%{public}@ : [L%{public}d) - searching [%{public}@]...",
               log: .default,
               type: .debug, #function, #line, searchText)
        self.searchResult = repository?.loadedElements.filter({ character in
            character.name?.hasPrefix(searchText) == true
        })
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        os_log("(%{public}@ : [L%{public}d) - searching [%{public}@]...",
               log: .default,
               type: .debug, #function, #line, searchBar.text ?? "***")
        guard let text = searchBar.text, text.isEmpty == false else {
            searchBar.resignFirstResponder()
            return
        }
        self.repository?.items(withNameStarting: text, completion: { result in
            switch result {
            case let .success(characters):
                self.searchResult = characters
            case let .failure(error):
                print(error.localizedDescription)
                self.state = .empty
            }
        })
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        os_log("(%{public}@ : [L%{public}d) - searchBarCancelButtonClicked [%{public}@]...",
               log: .default,
               type: .debug, #function, #line, searchBar.text ?? "***")
        self.searchResult = nil
        self.collectionView?.reloadData()
        searchBar.resignFirstResponder()
    }

    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        os_log("(%{public}@ : [L%{public}d) - [%{public}@]...",
               log: .default,
               type: .debug, #function, #line, searchBar.text ?? "***")
    }
}
