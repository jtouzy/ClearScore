//
//  DataLayerError.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

protocol DataLayerError: Error {
    var identifier: String { get }
    var localizedMessage: String { get }
}
