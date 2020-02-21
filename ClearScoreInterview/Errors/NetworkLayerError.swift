//
//  NetworkLayerError.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

enum NetworkLayerError: DataLayerError {
    case cantBuildServiceURL
    case cantDeserialize(cause: Error?)
    case networkFailure(cause: Error?)
    case noDataFetched

    var identifier: String {
        switch self {
        case .cantBuildServiceURL:
            return "cantBuildServiceURL"
        case .cantDeserialize(_):
            return "cantDeserialize"
        case .networkFailure(_):
            return "networkFailure"
        case .noDataFetched:
            return "noDataFetched"
        }
    }
}
