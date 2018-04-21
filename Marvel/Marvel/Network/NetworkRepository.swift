//
//  NetworkRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

// Greatly inspired by: https://github.com/MrAlek/PagedArray
// See more: http://www.iosnomad.com/blog/2014/4/21/fluent-pagination

struct NetworkRepository<T> {
    typealias PageIndex = Int

    /// The datastorage
    public fileprivate(set) var elements = [PageIndex: [T]]()

    /// The size of each page
    public let pageSize: Int

    /// The total count of supposed elements, including nil values
    public var count: Int

    /// The starting page index
    public let startPage: PageIndex

    /// The last valid page index
    public var lastPage: PageIndex {
        if count == 0 {
            return 0
        } else if count%pageSize == 0 {
            return count/pageSize+startPage-1
        } else {
            return count/pageSize+startPage
        }
    }

    /// All elements currently set, in order
    public var loadedElements: [T] {
        return self.compactMap { $0 }
    }

    /// Creates an empty `PagedArray`
    public init(count: Int, pageSize: Int, startPage: PageIndex = 0) {
        self.count = count
        self.pageSize = pageSize
        self.startPage = startPage
    }

    // MARK: Public functions

    /// Returns the page index for an element index
    public func page(for index: Index) -> PageIndex {
        assert(index >= startIndex && index < endIndex, "Index out of bounds")
        return index/pageSize+startPage
    }

    /// Returns a `Range` corresponding to the indexes for a page
    public func indexes(for page: PageIndex) -> CountableRange<Index> {
        assert(page >= startPage && page <= lastPage, "Page index out of bounds")

        let start: Index = (page-startPage)*pageSize
        let end: Index
        if page == lastPage {
            end = count
        } else {
            end = start+pageSize
        }

        return (start..<end)
    }

    // MARK: Public mutating functions

    /// Sets a page of elements for a page index
    public mutating func set(_ elements: [T], forPage page: PageIndex) {
        assert(page >= startPage, "Page index out of bounds")
        assert(count == 0 || elements.count > 0, "Can't set empty elements page on non-empty array")

        let pageIndexForExpectedSize = (page > lastPage) ? lastPage : page
        let expectedSize = size(for: pageIndexForExpectedSize)

        assert(page <= lastPage, "Page index out of bounds")
        assert(elements.count == expectedSize, "Incorrect page size")

        self.elements[page] = elements
    }

    /// Removes the elements corresponding to the page, replacing them with `nil` values
    public mutating func remove(_ page: PageIndex) {
        elements[page] = nil
    }

    /// Removes all loaded elements, replacing them with `nil` values
    public mutating func removeAllPages() {
        elements.removeAll(keepingCapacity: true)
    }

}

// MARK: SequenceType

extension NetworkRepository : Sequence {
    public func makeIterator() -> IndexingIterator<NetworkRepository> {
        return IndexingIterator(_elements: self)
    }
}

// MARK: CollectionType

extension NetworkRepository : BidirectionalCollection {

    public typealias Index = Int

    public var startIndex: Index { return 0 }
    public var endIndex: Index { return count }

    public func index(after i: Index) -> Index {
        return i+1
    }

    public func index(before i: Index) -> Index {
        return i-1
    }

    /// Accesses and sets elements for a given flat index position.
    /// Currently, setter can only be used to replace non-optional values.
    subscript (position: Index) -> T? {
        get {
            let pageIndex = page(for: position)

            if let page = elements[pageIndex] {
                return page[position % pageSize]
            } else {
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
        return indexes.endIndex-indexes.startIndex
    }
}

