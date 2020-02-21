//
//  CreditScorePresenter.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

protocol CreditScorePresenter {
    func didLoad()
}

class CreditScorePresenterImpl {
    weak var view: CreditScoreView?
    lazy var dataProvider: DataProvider = HTTPDataProvider() // FIXME: Interactor

    init(view: CreditScoreView) {
        self.view = view
    }
}

extension CreditScorePresenterImpl: CreditScorePresenter {
    func didLoad() {
        view?.setLoadingState()
        dataProvider.fetchCreditScore { [weak self] creditScore, error in
            guard let self = self else { return }
            if let creditScore = creditScore {
                let score = creditScore.creditReportInfo.score
                let maxScore = creditScore.creditReportInfo.maxScoreValue
                self.view?.setScoreState(CreditScoreModelUI(
                    score: "\(score)",
                    maxScore: "out of \(maxScore)",
                    percentage: Double((score * 100) / maxScore)
                ))
            }
        }
    }
}
