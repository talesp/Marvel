//
//  NetworkRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

// Greatly inspired by/"forked" from: https://github.com/MrAlek/PagedArray
// See more: http://www.iosnomad.com/blog/2014/4/21/fluent-pagination

class NetworkRepository<T: PagedResource> {
    typealias PageIndex = Int

    private var _startIndex = -1
    private var dataLoadingOperations: [Int: URLSessionDataTask] = [:]

    private(set) var webservice: Webservice

    /// The datastorage
    fileprivate(set) var elements = [PageIndex: [T]]()

    /// The size of each page
    let pageSize: Int

    /// The total count of supposed elements, including nil values
    var count: Int = 0

    /// The starting page index
    let startPage: PageIndex

    /// The last valid page index
    var lastPage: PageIndex {
        if count == 0 {
            return 0
        }
        else if count % pageSize == 0 {
            return count / pageSize + startPage - 1
        }
        else {
            return count / pageSize + startPage
        }
    }

    /// All elements currently set, in order
    var loadedElements: [T] {
        return self.compactMap { $0 }
    }

    private(set) var updatedData: ([T], PageIndex) -> Void

    init(pageSize: Int = 20,
         startPage: PageIndex = 0,
         webservice: Webservice = Webservice(),
         updatedData: @escaping ([T], PageIndex) -> Void) {
        self.pageSize = pageSize
        self.startPage = startPage
        self.webservice = webservice
        self.updatedData = updatedData
        loadData(for: startPage)
    }

    // MARK: functions
    func clearData() {
        for (_, task) in dataLoadingOperations {
            task.cancel()
        }
        dataLoadingOperations.removeAll(keepingCapacity: true)
        removeAllPages()
    }

    /// Removes the elements corresponding to the page, replacing them with `nil` values
    func remove(_ page: PageIndex) {
        elements[page] = nil
    }

    /// Removes all loaded elements, replacing them with `nil` values
    func removeAllPages() {
        elements.removeAll(keepingCapacity: true)
    }

    func loadDataIfNeeded(for currentPage: Int) {
        if needsLoadDataForPage(currentPage) {
            loadData(for: currentPage)
        }


        let preloadIndex = currentPage * pageSize
        if preloadIndex < endIndex {
            let preloadPage = page(for: preloadIndex)
            if preloadPage > currentPage && needsLoadDataForPage(preloadPage) {
                loadData(for: preloadPage)
            }
        }
    }

    func loadDataIfNeededFor(index: Index) {
        let currentPage = page(for: index)

        loadDataIfNeeded(for: currentPage)

    }

    /// Returns the page index for an element index
    func page(for index: Index) -> PageIndex {
        guard startIndex >= 0 && endIndex != 0 else { return 0 }
        assert(index >= startIndex && index < endIndex, "Index out of bounds")
        return index / pageSize + startPage
    }

    /// Returns a `Range` corresponding to the indexes for a page
    private func indexes(for page: PageIndex) -> CountableRange<Index> {
        assert(page >= startPage && page <= lastPage, "Page index out of bounds")

        let start: Index = (page - startPage) * pageSize
        let end: Index
        if page == lastPage {
            end = count
        }
        else {
            end = start + pageSize
        }

        return (start..<end)
    }

    private func needsLoadDataForPage(_ page: Int) -> Bool {
        return elements[page] == nil && dataLoadingOperations[page] == nil
    }

    func loadData(for page: Int) {

        self._startIndex = 0
        // Create loading operation
        let resource = T.resource(for: page, pageSize: self.pageSize)
        let task = webservice.load(resource) { [weak self] result in

            switch result {
            case let .success(dataPage):
                // Set elements on paged array
                self?.count = dataPage.data.total
                self?.set(dataPage.data.results, forPage: page)

                // Cleanup
                self?.dataLoadingOperations[page] = nil
                self?.updatedData(dataPage.data.results, page)
            case let .failure(error):
                fatalError("TODO: [\(error.localizedDescription)]")
            }
        }

        dataLoadingOperations[page] = task
    }
    // MARK: functions

    /// Sets a page of elements for a page index
    private func set(_ elements: [T], forPage page: PageIndex) {
        assert(page >= startPage, "Page index out of bounds")
        assert(count == 0 || elements.count > 0, "Can't set empty elements page on non-empty array")

        let pageIndexForExpectedSize = (page > lastPage) ? lastPage : page
        let expectedSize = size(for: pageIndexForExpectedSize)

        assert(page <= lastPage, "Page index out of bounds")
        assert(elements.count == expectedSize, "Incorrect page size")

        self.elements[page] = elements
    }
}

// MARK: SequenceType

extension NetworkRepository: Sequence {
    func makeIterator() -> IndexingIterator<NetworkRepository> {
        return IndexingIterator(_elements: self)
    }
}

// MARK: CollectionType
extension NetworkRepository: BidirectionalCollection {

    typealias Index = Int

    var startIndex: Index { return _startIndex }
    var endIndex: Index { return count }

    func index(after index: Index) -> Index {
        return index + 1
    }

    func index(before index: Index) -> Index {
        return index - 1
    }

    /// Accesses and sets elements for a given flat index position.
    /// Currently, setter can only be used to replace non-optional values.
    subscript (position: Index) -> T? {
        get {

            loadDataIfNeededFor(index: position)

            let pageIndex = page(for: position)

            if let page = elements[pageIndex] {
                return page[position % pageSize]
            }
            else {
                // Return nil for all pages that haven't been set yet
                return nil
            }
        }

        set(newValue) {
            guard let newValue = newValue else { return }

            let pageIndex = page(for: position)
            var elementPage = elements[pageIndex]
            elementPage?[position % pageSize] = newValue
            elements[pageIndex] = elementPage
        }
    }
}

// MARK: Private functions

private extension NetworkRepository {
    func size(for page: PageIndex) -> Int {
        let indexes = self.indexes(for: page)
        return indexes.endIndex - indexes.startIndex
    }
}
