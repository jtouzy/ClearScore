//
//  URLSession+extensions.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

extension URLSession: HTTPInvoker {
    func call(request: URLRequest, completionHandler: @escaping DataTaskResult) {
        let task = dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
}
