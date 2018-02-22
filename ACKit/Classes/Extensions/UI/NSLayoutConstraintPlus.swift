//
//  NSLayoutConstraintPlus.swift
//  ACKit
//
//  Created by Austin Chen on 2018-02-21.
//

import UIKit

extension Array where Element == NSLayoutConstraint {
    public func front(_ predicate: (Element) throws -> Bool) rethrows -> Element? {
        // filter out private Constraints etc other than NSLayoutConstraint
        return first(where: {
            type(of: $0) == Element.self && (try! predicate($0))
        })
    }
}
