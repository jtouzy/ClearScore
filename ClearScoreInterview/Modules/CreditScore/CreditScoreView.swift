//
//  CreditScoreView.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

protocol CreditScoreView: class {
    func setLoadingState()
    func setScoreState(_ model: CreditScoreModelUI)
    func setErrorState(_ message: String)
}

struct CreditScoreViewControllerSpecs {
    static let containerCircleRadius: CGFloat = UIScreen.main.bounds.size.width / 3
    static let containerCircleBorderWidth: CGFloat = 1
    static let containerCircleBorderColor: UIColor? = .creditScoreContainerCircleBorder
    static let scoreCircleRadius: CGFloat = containerCircleRadius - 10
    static let scoreCircleBorderColor: UIColor? = .primary
    static let scoreCircleBorderWidth: CGFloat = 4
    static let showActivityIndicatorAnimationDuration: TimeInterval = 0.2
    static let hideActivityIndicatorAnimationDuration: TimeInterval = 0.5
    static let drawCirclesAnimationDuration: TimeInterval = 0.5
    static let drawLabelsAnimationDuration: TimeInterval = 0.5
}

private typealias Specs = CreditScoreViewControllerSpecs

class CreditScoreViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var presentationLabel: UILabel! {
        didSet {
            presentationLabel.hide()
            presentationLabel.text = "credit_score_presentation".localized
        }
    }
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet { scoreLabel.hide() }
    }
    @IBOutlet weak var maximumScoreLabel: UILabel! {
        didSet { maximumScoreLabel.hide() }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet { activityIndicator.hide() }
    }
    @IBOutlet weak var errorLabel: UILabel! {
        didSet { errorLabel.hide() }
    }
    @IBOutlet weak var retryButton: UIButton! {
        didSet { retryButton.hide() }
    }

    var presenter: CreditScorePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "credit_score_title".localized
        presenter?.didLoad()
    }

    @IBAction func retryClickHandler(_ sender: UIButton) {
        presenter?.didTapRetry()
    }
}

extension CreditScoreViewController: CreditScoreView {
    func setLoadingState() {
        errorLabel.hide()
        retryButton.hide()
        // NOTE: Animation to show activityIndicator and hide errors if present
        UIView.animate(withDuration: Specs.showActivityIndicatorAnimationDuration,
                       animations: { [weak self] in
            self?.activityIndicator.show()
        })
    }

    func setScoreState(_ model: CreditScoreModelUI) {
        hideActivityIndicatorWithAnimation { [weak self] in
            guard let self = self else { return }
            // NOTE: Second animation: Draw score circle + Draw black container circle
            self.drawContainerCircle()
            self.drawScoreCircleWithAnimation(percentage: model.percentage)
            // NOTE: Third animation: Draw labels
            UIView.animate(withDuration: Specs.drawLabelsAnimationDuration,
                           delay: Specs.drawCirclesAnimationDuration,
                           animations: {
                self.presentationLabel.show()
                self.scoreLabel.show()
                self.scoreLabel.text = model.score
                self.maximumScoreLabel.show()
                self.maximumScoreLabel.text = model.maxScore
            })
        }
    }

    func setErrorState(_ message: String) {
        hideActivityIndicatorWithAnimation { [weak self] in
            guard let self = self else { return }
            // NOTE: Second animation: Draw error labels
            UIView.animate(withDuration: Specs.drawLabelsAnimationDuration,
                           animations: {
                self.errorLabel.show()
                self.errorLabel.text = message
                self.retryButton.show()
            })
        }
    }
}

extension CreditScoreViewController {
    private func hideActivityIndicatorWithAnimation(andThen completion: @escaping () -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // NOTE: First animation: Hide activity indicator
            UIView.animate(withDuration: Specs.hideActivityIndicatorAnimationDuration, animations: {
                self.activityIndicator.alpha = 0
            }, completion: { _ in
                self.activityIndicator.isHidden = true
                completion()
            })
        }
    }

    private func drawContainerCircle() {
        let shapeLayer = view.drawCircle(
            fromCenter: stackView.center,
            radius: Specs.containerCircleRadius,
            fillColor: view.backgroundColor,
            borderColor: Specs.containerCircleBorderColor,
            borderWidth: Specs.containerCircleBorderWidth,
            layerIndex: 0
        )
        shapeLayer.opacity = 0
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        basicAnimation.duration = Specs.drawCirclesAnimationDuration
        basicAnimation.toValue = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "drawContainerCircleAnimation")
    }

    private func drawScoreCircleWithAnimation(percentage: Double) {
        let shapeLayer = view.drawCircle(
            fromCenter: stackView.center,
            radius: Specs.scoreCircleRadius,
            fillColor: view.backgroundColor,
            borderColor: Specs.scoreCircleBorderColor,
            borderWidth: Specs.scoreCircleBorderWidth,
            layerIndex: 1
        )
        shapeLayer.strokeEnd = 0
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = Specs.drawCirclesAnimationDuration
        basicAnimation.toValue = percentage / 100
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "drawScoreCircleAnimation")
    }
}
