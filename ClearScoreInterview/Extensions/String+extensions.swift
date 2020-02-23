//
//  String+extensions.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 22/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

//
// MARK: Extension to simplify the use of localized strings.
//
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localizedWith(_ params: CVarArg...) -> String {
        return String(format: localized, arguments: params)
    }
}
