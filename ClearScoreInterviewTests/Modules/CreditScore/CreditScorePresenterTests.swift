//
//  CreditScorePresenterTests.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

@testable import ClearScore
import XCTest

class CreditScorePresenterTests: XCTestCase {
    private typealias Package = (
        sut: CreditScorePresenter,
        view: CreditScoreViewMock,
        dataProvider: DataProviderMock
    )

    private func createSUT(data: CreditScore? = nil, error: DataLayerError? = nil) -> Package {
        let viewMock = CreditScoreViewMock()
        let dataProviderMock = DataProviderMock(data: data, error: error)
        let sut = CreditScorePresenterImpl(view: viewMock)
        sut.dataProvider = dataProviderMock
        return (
            sut: sut,
            view: viewMock,
            dataProvider: dataProviderMock
        )
    }
}

extension CreditScorePresenterTests {
    func test_didLoad_shouldChangeViewStateAndCallDataProvider() {
        // Given
        let package = createSUT()
        // When
        package.sut.didLoad()
        // Then
        XCTAssertTrue(package.view.setLoadingStateStatus.isCalled)
        XCTAssertTrue(package.dataProvider.fetchCreditScoreStatus.isCalled)
    }

    func test_didLoad_shouldInvokeViewUpdate() {
        // Given
        let reportInfo = CreditReportInfo(score: 100, minScoreValue: 0, maxScoreValue: 200)
        let package = createSUT(data: CreditScore(creditReportInfo: reportInfo))
        // When
        package.sut.didLoad()
        // Then
        XCTAssertTrue(package.view.setScoreStateStatus.isCalled)
        guard let firstCallParam = package.view.setScoreStateStatus.firstCallParam else {
            XCTFail("setScoreState should be called")
            return
        }
        XCTAssertEqual(firstCallParam.score, "\(reportInfo.score)")
        XCTAssertEqual(firstCallParam.maxScore, "out of \(reportInfo.maxScoreValue)")
        XCTAssertEqual(firstCallParam.percentage, 50)
    }

    func test_didLoad_shouldInvokeViewUpdateWithError() {
        // Given
        let package = createSUT(error: NetworkLayerError.networkFailure(cause: nil))
        // When
        package.sut.didLoad()
        // Then
        XCTAssertTrue(package.view.setErrorStatus.isCalled)
        guard let firstCallParam = package.view.setErrorStatus.firstCallParam else {
            XCTFail("setErrorState should be called")
            return
        }
        XCTAssertEqual(firstCallParam, NetworkLayerError.networkFailure(cause: nil).localizedMessage)
    }
}
