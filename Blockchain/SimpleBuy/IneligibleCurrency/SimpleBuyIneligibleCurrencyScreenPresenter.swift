//
//  SimpleBuyIneligibleCurrencyScreenPresenter.swift
//  Blockchain
//
//  Created by Alex McGregor on 4/2/20.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import RxSwift
import RxCocoa
import PlatformKit
import PlatformUIKit
import ToolKit

final class SimpleBuyIneligibleCurrencyScreenPresenter {
    
    // MARK: - Types
    
    private typealias AnalyticsEvent = AnalyticsEvents.SimpleBuy
    private typealias LocalizationString = LocalizationConstants.SimpleBuy.Ineligible
    private typealias AccessibilityID = Accessibility.Identifier.SimpleBuy.IneligibleCurrency
    
    // MARK: - Rx
    
    let dismissalRelay = PublishRelay<Void>()
    let restartRelay = PublishRelay<Void>()
    
    // MARK: - Public Properties
    
    let thumbnail = UIImage.init(named: "icon-error-region") ?? .init()
    let changeCurrencyButtonViewModel: ButtonViewModel
    let viewHomeButtonViewModel: ButtonViewModel
    let titleLabelContent: LabelContent
    let descriptionLabelContent: LabelContent
    
    // MARK: - Private Properties
    
    private unowned let coordinator: AppCoordinator
    private let disposeBag = DisposeBag()
    
    init(currency: FiatCurrency,
         coordinator: AppCoordinator = AppCoordinator.shared,
         analyticsRecording: AnalyticsEventRecording = AnalyticsEventRecorder.shared) {
        self.coordinator = coordinator
        titleLabelContent = .init(
            text: "\(currency.name) \(LocalizationString.title)",
            font: .mainSemibold(20.0),
            color: .titleText,
            alignment: .center,
            accessibility: .id(AccessibilityID.titleLabel)
        )
        
        descriptionLabelContent = .init(
            text: "\(LocalizationString.description) \(currency.name).",
            font: .mainMedium(14.0),
            color: .titleText,
            alignment: .center,
            accessibility: .id(AccessibilityID.descriptionLabel)
        )
        
        viewHomeButtonViewModel = .secondary(with: LocalizationString.viewHome,
                                             accessibilityId: AccessibilityID.viewHome)
        viewHomeButtonViewModel.tapRelay
            .record(analyticsEvent: AnalyticsEvent.sbUnsupportedViewHome, using: analyticsRecording)
            .bind(to: dismissalRelay)
            .disposed(by: disposeBag)
        
        changeCurrencyButtonViewModel = .primary(with: LocalizationString.changeCurrency,
                                                 accessibilityId: AccessibilityID.changeCurrency)
        changeCurrencyButtonViewModel.tapRelay
            .record(analyticsEvent: AnalyticsEvent.sbUnsupportedChangeCurrency, using: analyticsRecording)
            .bind(to: restartRelay)
            .disposed(by: disposeBag)
    }
    
    func resumeSimpleBuy() {
        coordinator.handleBuyCrypto(simpleBuy: true)
    }
}
