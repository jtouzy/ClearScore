//
//  CreditScorePresenter.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: Presenter protocol
//
protocol CreditScorePresenter {
    func didLoad()
    func didTapRetry()
}

//
// MARK: Presenter implementation
//
class CreditScorePresenterImpl {
    weak var view: CreditScoreView?
    lazy var dataProvider: DataProvider = HTTPDataProvider()

    init(view: CreditScoreView) {
        self.view = view
    }
}

//
// MARK: Extension for presenter protocol implementation
//
extension CreditScorePresenterImpl: CreditScorePresenter {
    func didLoad() {
        fetchCreditScoreWithLoader()
    }

    func didTapRetry() {
        fetchCreditScoreWithLoader()
    }
}

//
// MARK: Extension for private functions
//
extension CreditScorePresenterImpl {
    private func fetchCreditScoreWithLoader() {
        view?.setLoadingState()
        dataProvider.fetchCreditScore { [weak self] creditScore, error in
            guard let self = self else { return }
            if let creditScore = creditScore {
                let score = creditScore.creditReportInfo.score
                let maxScore = creditScore.creditReportInfo.maxScoreValue
                self.view?.setScoreState(CreditScoreModelUI(
                    score: "\(score)",
                    maxScore: "credit_score_maximum".localizedWith("\(maxScore)"),
                    percentage: Double((score * 100) / maxScore)
                ))
            } else if let error = error {
                self.view?.setErrorState(error.localizedMessage)
            }
        }
    }
}
