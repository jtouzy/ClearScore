//
//  ViewController.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

private struct Specs {
    static let containerCircleRadius: CGFloat = UIScreen.main.bounds.size.width / 3
    static let containerCircleBorderColor: UIColor = .black
    static let containerCircleBorderWidth: CGFloat = 1
    static let scoreCircleRadius: CGFloat = containerCircleRadius - 10
    static let scoreCircleBorderColor: UIColor = .red
    static let scoreCircleBorderWidth: CGFloat = 4
    static let hideActivityIndicatorAnimationDuration: TimeInterval = 0.5
    static let drawCirclesAnimationDuration: TimeInterval = 0.5
    static let drawLabelsAndCircleAnimationDuration: TimeInterval = 0.5
}

class ViewController: UIViewController {
    @IBOutlet weak var presentationLabel: UILabel! {
        didSet { presentationLabel.isHidden = true }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingState()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.setScoreState(score: 200, maxScore: 700)
        })
    }
}

extension ViewController {
    func setLoadingState() {
        activityIndicator.isHidden = false
    }

    func setScoreState(score: Int, maxScore: Int) {
        // NOTE: First animation: Hide activity indicator
        UIView.animate(withDuration: Specs.hideActivityIndicatorAnimationDuration,
                       animations: { [weak self] in
            self?.activityIndicator.alpha = 0
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.activityIndicator.isHidden = true
            // NOTE: Second animation: Draw score circle + Draw black container circle
            self.drawContainerCircle()
            self.drawScoreCircleWithAnimation()
            // NOTE: Third animation: Draw labels
            UIView.animate(withDuration: Specs.drawLabelsAndCircleAnimationDuration,
                           delay: Specs.drawCirclesAnimationDuration,
                           animations: {
                self.presentationLabel.isHidden = false
                self.scoreLabel.isHidden = false
                self.maximumScoreLabel.isHidden = false
            })
        })
    }
}

extension ViewController {
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

    private func drawScoreCircleWithAnimation() {
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
        basicAnimation.toValue = 0.7
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "drawScoreCircleAnimation")
    }
}
