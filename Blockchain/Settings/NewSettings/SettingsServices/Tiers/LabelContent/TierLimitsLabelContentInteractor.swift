//
//  TierLimitsLabelContentInteractor.swift
//  Blockchain
//
//  Created by AlexM on 12/16/19.
//  Copyright © 2019 Blockchain Luxembourg S.A. All rights reserved.
//

import PlatformUIKit
import PlatformKit
import RxSwift
import RxRelay

final class TierLimitsLabelContentInteractor: LabelContentInteracting {
    
    // MARK: - Types
    
    typealias InteractionState = LabelContentAsset.State.LabelItem.Interaction
    
    // MARK: - Properties
    
    let stateRelay = BehaviorRelay<InteractionState>(value: .loading)
    var state: Observable<InteractionState> {
        return stateRelay.asObservable()
    }
    
    // MARK: - Private Accessors
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Setup 
    
    init(limitsProviding: TierLimitsProviding) {
        limitsProviding.tiers
            .map { _ in .loaded(next: .init(text: LocalizationConstants.KYC.accountLimits)) }
            .bind(to: stateRelay)
            .disposed(by: disposeBag)
    }
}
