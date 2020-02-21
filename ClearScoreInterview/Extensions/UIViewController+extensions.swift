//
//  UIViewController+extensions.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

extension UIViewController {
    static let mainStoryboard = "Main"

    static func load<T: UIViewController>() -> T? {
        let storyboard = UIStoryboard(name: mainStoryboard, bundle: .main)
        return storyboard.instantiateViewController(identifier: T.identifier) as? T
    }
}

extension UIViewController: UIIdentifiable {}
