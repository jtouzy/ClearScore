//
//  CreditReportInfo.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class CreditReportInfo: Codable {
    let score: Int
    let minScoreValue: Int
    let maxScoreValue: Int

    init(score: Int, minScoreValue: Int, maxScoreValue: Int) {
        self.score = score
        self.minScoreValue = minScoreValue
        self.maxScoreValue = maxScoreValue
    }
}

extension CreditReportInfo: Equatable {
    static func == (rhs: CreditReportInfo, lhs: CreditReportInfo) -> Bool {
        return rhs.score == lhs.score &&
            rhs.minScoreValue == lhs.minScoreValue &&
            rhs.maxScoreValue == lhs.maxScoreValue
    }
}
