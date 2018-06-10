//
//  CharacterListViewModelPrefetching.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 06/06/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import os.log

class CharacterListViewModelPrefetching: NSObject, UICollectionViewDataSourcePrefetching {
    private weak var repository: CharacterNetworkRepository?

    init(repository: CharacterNetworkRepository) {
        self.repository = repository
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        os_log("IndexPaths: %{public}@", log: .default, type: .debug, indexPaths)

        guard let repository = self.repository,
            let maxIndex = indexPaths.max(by: { $0.row > $1.row })?.row else { return }

        let page = Int(floor(Double(maxIndex) / Double(repository.pageSize)))

        repository.items(pageIndex: page) { characters in
            os_log("IndexPaths: %{public}@ - page: %{public}d", log: .default, type: .debug, String(describing: indexPaths), page)
//            collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        }
    }

}