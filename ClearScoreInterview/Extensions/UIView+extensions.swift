//
//  UIView+extensions.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult func drawCircle(
        fromCenter center: CGPoint? = nil,
        radius: CGFloat,
        fillColor: UIColor? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        layerIndex: UInt32 = 0
    ) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(
            arcCenter: center ?? self.center,
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: 2 * .pi,
            clockwise: true
        )
        shapeLayer.fillColor = fillColor?.cgColor
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = borderColor?.cgColor
        if let borderWidth = borderWidth {
            shapeLayer.lineWidth = borderWidth
        }
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        layer.insertSublayer(shapeLayer, at: layerIndex)
        return shapeLayer
    }
}
