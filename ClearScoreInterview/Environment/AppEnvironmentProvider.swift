//
//  AppEnvironmentProvider.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

private enum InfoPlistKeys: String {
    case apiURL = "API_URL"
}

public class AppEnvironmentProvider {
    public static let shared = AppEnvironmentProvider()

    private let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            return [:]
        }
        return dict
    }()
}

extension AppEnvironmentProvider: EnvironmentProvider {
    var apiURL: String? {
        return infoDictionary[InfoPlistKeys.apiURL.rawValue] as? String
    }
}
