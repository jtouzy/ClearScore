//
//  CreditScoreModels.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class CreditScoreModelUI {
    let score: String
    let maxScore: String
    let percentage: Double

    init(score: String, maxScore: String, percentage: Double) {
        self.score = score
        self.maxScore = maxScore
        self.percentage = percentage
    }
}
