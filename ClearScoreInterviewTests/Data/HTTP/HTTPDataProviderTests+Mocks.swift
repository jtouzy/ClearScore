//
//  HTTPDataProviderTests+Mocks.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

@testable import ClearScore
import Foundation

class HTTPInvokerMock: HTTPInvoker {
    var callStatus = CallStatus<URLRequest>.none
    let data: Data?
    let error: Error?

    init(data: Data? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }

    func call(request: URLRequest, completionHandler: @escaping DataTaskResult) {
        callStatus.iterate(with: request)
        completionHandler(data, nil, error)
    }
}

class EnvironmentProviderMock: EnvironmentProvider {
    let apiURL: String?

    init(apiURL: String? = nil) {
        self.apiURL = apiURL
    }
}
