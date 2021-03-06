//
//  Rx+UIViewUtils.swift
//  Blockchain
//
//  Created by Daniel Huri on 08/06/2019.
//  Copyright © 2019 Blockchain Luxembourg S.A. All rights reserved.
//

import RxSwift
import RxCocoa

/// Extension for rx that makes `UIProgressView` properties reactive
extension Reactive where Base: UIProgressView {
    public var progress: Binder<Float> {
        return Binder(base) { view, progress in
            view.setProgress(progress, animated: true)
        }
    }
    
    public var trackTintColor: Binder<UIColor> {
        return Binder(base) { view, color in
            view.trackTintColor = color
        }
    }
    
    public var fillColor: Binder<UIColor> {
        return Binder(base) { view, color in
            view.progressTintColor = color
        }
    }
}

extension Reactive where Base: UILabel {
    public var textColor: Binder<UIColor> {
        return Binder(base) { label, color in
            label.textColor = color
        }
    }
}

extension Reactive where Base: UIImageView {
    /// If this value is `nil`, the image derives its `tintColor`
    /// from its superview.
    public var tintColor: Binder<UIColor?> {
        return Binder(base) { imageView, color in
            guard let tintColor = color else { return }
            imageView.tintColor = tintColor
        }
    }
}
