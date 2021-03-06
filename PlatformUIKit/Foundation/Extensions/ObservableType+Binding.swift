//
//  ObservableType+Binding.swift
//  PlatformUIKit
//
//  Created by Daniel Huri on 29/01/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import RxSwift
import RxCocoa
import ToolKit

extension ObservableType {
    public func bind<A: AnyObject>(weak object: A, onNext: @escaping (A, Element) -> Void) -> Disposable {
        return self
            .bind { [weak object] element in
                guard let object = object else { return }
                onNext(object, element)
            }
    }
    
    public func bind<A: AnyObject>(weak object: A, onNext: @escaping (A) -> Void) -> Disposable {
        return self
            .bind { [weak object] element in
                guard let object = object else { return }
                onNext(object)
            }
    }
}
