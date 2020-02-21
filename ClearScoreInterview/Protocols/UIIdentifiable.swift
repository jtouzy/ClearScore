//
//  UIIdentifiable.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

protocol UIIdentifiable {
    static var identifier: String { get }
}

extension UIIdentifiable {
    static var identifier: String {
        String(describing: self)
    }
}
