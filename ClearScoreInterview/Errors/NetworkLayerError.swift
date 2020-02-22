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

    var localizedMessage: String {
        switch self {
        case .cantBuildServiceURL:
            return "error_cant_build_service_url".localized
        case .cantDeserialize(_):
            return "error_cant_deserialize".localized
        case .networkFailure(_):
            return "error_network_failure".localized
        case .noDataFetched:
            return "error_no_data".localized
        }
    }
}
