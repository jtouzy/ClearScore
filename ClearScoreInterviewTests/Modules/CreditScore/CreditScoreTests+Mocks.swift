//
//  CreditScoreTests+Mocks.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

@testable import ClearScore
import Foundation

class DataProviderMock: DataProvider {
    var fetchCreditScoreStatus = CallStatus<Never>.none
    let data: CreditScore?
    let error: DataLayerError?

    init(data: CreditScore? = nil, error: DataLayerError? = nil) {
        self.data = data
        self.error = error
    }

    func fetchCreditScore(completion resultHandler: @escaping (CreditScore?, DataLayerError?) -> Void) {
        fetchCreditScoreStatus.iterate()
        resultHandler(data, error)
    }
}

class CreditScoreViewMock: CreditScoreView {
    var setLoadingStateStatus = CallStatus<Never>.none
    var setScoreStateStatus = CallStatus<CreditScoreModelUI>.none
    var setErrorStatus = CallStatus<String>.none

    func setLoadingState() {
        setLoadingStateStatus.iterate()
    }

    func setScoreState(_ model: CreditScoreModelUI) {
        setScoreStateStatus.iterate(with: model)
    }

    func setErrorState(_ message: String) {
        setErrorStatus.iterate(with: message)
    }
}

class CreditScorePresenterMock: CreditScorePresenter {
    var didLoadStatus = CallStatus<Never>.none
    var didTapRetryStatus = CallStatus<Never>.none

    func didLoad() {
        didLoadStatus.iterate()
    }

    func didTapRetry() {
        didTapRetryStatus.iterate()
    }
}
