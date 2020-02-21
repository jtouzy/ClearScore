//
//  CreditScoreAssembler.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

class CreditScoreAssembler {
    static func assemble() -> CreditScoreViewController? {
        guard let viewController: CreditScoreViewController = UIViewController.load() else {
            return nil
        }
        viewController.presenter = CreditScorePresenterImpl(view: viewController)
        return viewController
    }
}
