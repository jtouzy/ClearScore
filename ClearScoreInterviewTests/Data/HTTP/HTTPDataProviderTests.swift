//
//  HTTPDataProviderTests.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

@testable import ClearScoreInterview
import XCTest

private class HTTPInvokerMock: HTTPInvoker {
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

class HTTPDataProviderTests: XCTestCase {
    private typealias Package = (
        sut: HTTPDataProvider,
        httpInvoker: HTTPInvokerMock
    )

    private func createSUT(fromJsonFile fileName: String? = nil,
                           error: Error? = nil) -> Package {
        var data: Data?
        if let fileName = fileName {
            data = Bundle(for: HTTPDataProviderTests.self).jsonData(fromFile: fileName)
        }
        let httpInvokerMock = HTTPInvokerMock(data: data, error: error)
        let sut = HTTPDataProvider()
        sut.httpInvoker = httpInvokerMock
        return (sut: sut, httpInvoker: httpInvokerMock)
    }
}

// FIXME: Test error for non retrieving URL.

extension HTTPDataProviderTests {
    private typealias FetchCreditScoreSuccessHandler = (CreditScore?, CreditScore?, DataLayerError?) -> Void

    private func parameterized_fetchCreditScore_successful(
        expectationId: String, mockFile: String, searchExpected: Bool = true,
        handler: @escaping FetchCreditScoreSuccessHandler
    ) -> XCTestExpectation {
        // Given
        let expect = expectation(description: expectationId)
        let package = createSUT(fromJsonFile: mockFile, error: nil)
        // When
        package.sut.fetchCreditScore { creditScore, error in
            expect.fulfill()
            handler(
                searchExpected ? JSONDecoder().decode(CreditScore.self, fromFile: mockFile) : nil,
                creditScore,
                error
            )
        }
        return expect
    }

    func test_fetchCreditScore_withSuccessfulService_andData() {
        let expect = parameterized_fetchCreditScore_successful(
            expectationId: "test_fetchCreditScore_withSuccessfulService_andData",
            mockFile: "SuccessMock"
        ) { expectedData, creditScore, error in
            // Then
            XCTAssertNil(error)
            XCTAssertEqual(expectedData, creditScore)
        }
        wait(for: [expect], timeout: 0.1)
    }

    func test_fetchCreditScore_withSuccessfulService_andUnserializableData() {
        let expect = parameterized_fetchCreditScore_successful(
            expectationId: "test_fetchCreditScore_withSuccessfulService_andUnserializableData",
            mockFile: "InvalidJsonMock",
            searchExpected: false
        ) { expectedData, creditScore, error in
            // Then
            XCTAssertNil(creditScore)
            XCTAssertEqual(
                NetworkLayerError.cantDeserialize(cause: nil).identifier,
                error?.identifier
            )
        }
        wait(for: [expect], timeout: 0.1)
    }
}

extension HTTPDataProviderTests {
    private typealias FetchCreditScoreFailureHandler = (CreditScore?, DataLayerError?) -> Void

    private func parameterized_fetchCreditScore_failure(
        expectationId: String, error: Error? = nil,
        handler: @escaping FetchCreditScoreFailureHandler
    ) -> XCTestExpectation {
        // Given
        let expect = expectation(description: expectationId)
        let package = createSUT(fromJsonFile: nil, error: error)
        // When
        package.sut.fetchCreditScore { creditScore, error in
            expect.fulfill()
            handler(creditScore, error)
        }
        return expect
    }

    func test_fetchCreditScore_withNetworkFailure() {
        let expect = parameterized_fetchCreditScore_failure(
            expectationId: "test_fetchCreditScore_withNetworkFailure",
            error: TestError.failingCase
        ) { creditScore, error in
            // Then
            XCTAssertNil(creditScore)
            XCTAssertEqual(
                NetworkLayerError.networkFailure(cause: nil).identifier,
                error?.identifier
            )
        }
        wait(for: [expect], timeout: 0.1)
    }

    func test_fetchCreditScore_withNoDataAndError() {
        let expect = parameterized_fetchCreditScore_failure(
            expectationId: "test_fetchCreditScore_withNoDataAndError",
            error: nil
        ) { creditScore, error in
            // Then
            XCTAssertNil(creditScore)
            XCTAssertEqual(
                NetworkLayerError.noDataFetched.identifier,
                error?.identifier
            )
        }
        wait(for: [expect], timeout: 0.1)
    }
}
