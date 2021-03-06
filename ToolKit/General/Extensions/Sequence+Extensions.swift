//
//  Sequence+Extensions.swift
//  ToolKit
//
//  Created by Jack on 06/02/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import Foundation

extension Sequence {
    public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
}
