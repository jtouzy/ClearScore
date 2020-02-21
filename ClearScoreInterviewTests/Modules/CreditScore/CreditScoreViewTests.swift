//
//  CreditScoreViewTests.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

@testable import ClearScoreInterview
import XCTest

class CreditScoreViewControllerTests: XCTestCase {
    private typealias Package = (
        sut: CreditScoreViewController,
        presenter: CreditScorePresenterMock
    )

    private func createSUT() -> Package {
        let presenterMock = CreditScorePresenterMock()
        guard let sut: CreditScoreViewController = UIViewController.load() else {
            fatalError("Cannot build view controller for tests")
        }
        sut.presenter = presenterMock
        return (
            sut: sut,
            presenter: presenterMock
        )
    }
}

extension CreditScoreViewControllerTests {
    func test_viewDidLoad_shouldInvokePresenter() {
        // Given
        let package = createSUT()
        // When
        _ = package.sut.view
        // Then
        XCTAssertTrue(package.presenter.didLoadStatus.isCalled)
    }

    func test_setLoadingState_shouldShowOnlyActivityIndicator() {
        // Given
        let package = createSUT()
        _ = package.sut.view
        // When
        package.sut.setLoadingState()
        // Then
        XCTAssertFalse(package.sut.activityIndicator.isHidden)
        XCTAssertTrue(package.sut.presentationLabel.isHidden)
        XCTAssertTrue(package.sut.scoreLabel.isHidden)
        XCTAssertTrue(package.sut.maximumScoreLabel.isHidden)
    }

    func test_setScoreState_shouldShowDataAndHidesActivityIndicator() {
        // Given
        let package = createSUT()
        _ = package.sut.view
        // When
        package.sut.setScoreState(
            CreditScoreModelUI(score: "500", maxScore: "out of 1000", percentage: 50)
        )
        // Then
        waitForRunLoop(timeout:
            CreditScoreViewControllerSpecs.hideActivityIndicatorAnimationDuration +
            CreditScoreViewControllerSpecs.drawCirclesAnimationDuration +
            CreditScoreViewControllerSpecs.drawLabelsAnimationDuration
        )
        XCTAssertTrue(package.sut.activityIndicator.isHidden)
        XCTAssertFalse(package.sut.presentationLabel.isHidden)
        XCTAssertFalse(package.sut.scoreLabel.isHidden)
        XCTAssertEqual(package.sut.scoreLabel.text, "500")
        XCTAssertFalse(package.sut.maximumScoreLabel.isHidden)
        XCTAssertEqual(package.sut.maximumScoreLabel.text, "out of 1000")
    }
}
