//
//  HTTPInvoker.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

protocol HTTPInvoker {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func call(request: URLRequest, completionHandler: @escaping DataTaskResult)
}
