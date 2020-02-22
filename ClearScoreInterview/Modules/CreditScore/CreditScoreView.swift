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
}

struct CreditScoreViewControllerSpecs {
    static let containerCircleRadius: CGFloat = UIScreen.main.bounds.size.width / 3
    static let containerCircleBorderColor: UIColor = .black
    static let containerCircleBorderWidth: CGFloat = 1
    static let scoreCircleRadius: CGFloat = containerCircleRadius - 10
    static let scoreCircleBorderColor: UIColor? = .primary
    static let scoreCircleBorderWidth: CGFloat = 4
    static let hideActivityIndicatorAnimationDuration: TimeInterval = 0.5
    static let drawCirclesAnimationDuration: TimeInterval = 0.5
    static let drawLabelsAnimationDuration: TimeInterval = 0.5
}

private typealias Specs = CreditScoreViewControllerSpecs

class CreditScoreViewController: UIViewController {
    @IBOutlet weak var presentationLabel: UILabel! {
        didSet {
            presentationLabel.isHidden = true
            presentationLabel.text = "credit_score_presentation".localized
        }
    }
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet { scoreLabel.isHidden = true }
    }
    @IBOutlet weak var maximumScoreLabel: UILabel! {
        didSet { maximumScoreLabel.isHidden = true }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet { activityIndicator.isHidden = true }
    }

    var presenter: CreditScorePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoad()
    }
}

extension CreditScoreViewController: CreditScoreView {
    func setLoadingState() {
        activityIndicator.isHidden = false
    }

    func setScoreState(_ model: CreditScoreModelUI) {
        DispatchQueue.main.async { [weak self] in
            // NOTE: First animation: Hide activity indicator
            UIView.animate(withDuration: Specs.hideActivityIndicatorAnimationDuration, animations: {
                self?.activityIndicator.alpha = 0
            }, completion: { [weak self] _ in
                guard let self = self else { return }
                self.activityIndicator.isHidden = true
                // NOTE: Second animation: Draw score circle + Draw black container circle
                self.drawContainerCircle()
                self.drawScoreCircleWithAnimation(percentage: model.percentage)
                // NOTE: Third animation: Draw labels
                UIView.animate(withDuration: Specs.drawLabelsAnimationDuration,
                               delay: Specs.drawCirclesAnimationDuration,
                               animations: {
                    self.presentationLabel.isHidden = false
                    self.scoreLabel.isHidden = false
                    self.scoreLabel.text = model.score
                    self.maximumScoreLabel.isHidden = false
                    self.maximumScoreLabel.text = model.maxScore
                })
            })
        }
    }
}

extension CreditScoreViewController {
    private func drawContainerCircle() {
        let shapeLayer = view.drawCircle(
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
        let shapeLayer = self.view.drawCircle(
            radius: Specs.scoreCircleRadius,
            fillColor: self.view.backgroundColor,
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
