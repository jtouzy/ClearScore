//
//  HTTPDataProvider.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

enum HTTPRoute: String {
    case fetchCreditScore = "mockcredit/values"
}

class HTTPDataProvider {
    lazy var httpInvoker: HTTPInvoker = URLSession.shared
    lazy var environmentProvider: EnvironmentProvider = AppEnvironmentProvider.shared
}

//
// MARK: Extension implementing the DataProvider interface.
//
extension HTTPDataProvider: DataProvider {
    typealias FetchCreditScoreHandler = (CreditScore?, DataLayerError?) -> Void

    func fetchCreditScore(completion resultHandler: @escaping FetchCreditScoreHandler) {
        guard let request = buildURLRequest(for: .fetchCreditScore) else {
            resultHandler(nil, NetworkLayerError.cantBuildServiceURL)
            return
        }
        httpInvoker.call(request: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data {
                self.processSuccessResponse(from: data, completion: resultHandler)
            } else {
                resultHandler(nil, self.processErrorOrEmptyResponse(with: error))
            }
        }
    }
}

//
// MARK: Extension with private data functions.
// Methods are generic, for handling future API calls.
//
extension HTTPDataProvider {
    private func buildURLRequest(for route: HTTPRoute) -> URLRequest? {
        guard
            let baseUrl = environmentProvider.apiURL,
            let url = URL(string: baseUrl)?.appendingPathComponent(route.rawValue)
        else {
            return nil
        }
        return URLRequest(url: url)
    }

    private func processSuccessResponse<T>(
        from data: Data, completion resultHandler: @escaping (T?, DataLayerError?) -> Void
    ) where T: Decodable {
        do {
            let deserializedResult = try JSONDecoder().decode(T.self, from: data)
            resultHandler(deserializedResult, nil)
        } catch (let error) {
            resultHandler(nil, NetworkLayerError.cantDeserialize(cause: error))
        }
    }

    private func processErrorOrEmptyResponse(with error: Error?) -> NetworkLayerError {
        if let error = error {
            return .networkFailure(cause: error)
        }
        return .noDataFetched
    }
}
