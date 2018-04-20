//
//  Optional.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 20/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

// from: https://gist.github.com/erica/423e4b1c63b95c4c90338cdff4939a9b

infix operator !!: NilCoalescingPrecedence

extension Optional {
    /// Performs a forced unwrap operation, returning
    /// the wrapped value of an `Optional` instance
    /// or performing a `fatalError` with the string
    /// on the rhs of the operator.
    ///
    /// Forced unwrapping unwraps the left-hand side
    /// if it has a value or errors if it does not.
    /// The result of a successful operation will
    /// be the same type as the wrapped value of its
    /// left-hand side argument.
    ///
    /// This operator uses short-circuit evaluation:
    /// The `optional` lhs is checked first, and the
    /// `fatalError` is called only if the left hand
    /// side is nil. For example:
    ///
    ///    guard !lastItem.isEmpty else { return }
    ///    let lastItem = array.last !! "Array guaranteed to be non-empty because..."
    ///
    ///    let willFail = [].last !! "Array should have been guaranteed to be non-empty because..."
    ///
    ///
    /// In this example, `lastItem` is assigned the last value
    /// in `array` because the array is guaranteed to be non-empty.
    /// `willFail` is never assigned as the last item in an empty array is nil.
    /// - Parameters:
    ///   - optional: An optional value.
    ///   - message: A message to emit via `fatalError` after
    ///     failing to unwrap the optional.
    public static func !! (optional: Optional, errorMessage: @autoclosure () -> String) -> Wrapped {
        if let value = optional { return value }
        fatalError(errorMessage())
    }
}
