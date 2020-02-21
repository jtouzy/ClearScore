//
//  CreditScore.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class CreditScore: Codable {
    let creditReportInfo: CreditReportInfo

    init(creditReportInfo: CreditReportInfo) {
        self.creditReportInfo = creditReportInfo
    }
}

extension CreditScore: Equatable {
    static func == (rhs: CreditScore, lhs: CreditScore) -> Bool {
        return rhs.creditReportInfo == lhs.creditReportInfo
    }
}
