//
//  HTTPDataProvider.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

class HTTPDataProvider {
    static let url = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
    lazy var httpInvoker: HTTPInvoker = URLSession.shared
}

//
// MARK: Extension implementing the DataProvider interface.
//
extension HTTPDataProvider: DataProvider {
    typealias FetchCreditScoreHandler = (CreditScore?, DataLayerError?) -> Void

    func fetchCreditScore(completion resultHandler: @escaping FetchCreditScoreHandler) {
        guard let url = URL(string: HTTPDataProvider.url) else {
            resultHandler(nil, NetworkLayerError.cantBuildServiceURL)
            return
        }
        httpInvoker.call(request: URLRequest(url: url)) { [weak self] data, response, error in
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
