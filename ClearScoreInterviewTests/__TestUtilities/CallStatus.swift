//
//  CallStatus.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

public enum CallStatus<T> {
    case none
    case called(iterations: Int, results: [T])

    public var firstCallParam: T? {
        switch self {
        case .none:
            return nil
        case .called(_, let results):
            return results.first
        }
    }

    public var lastCallParam: T? {
        switch self {
        case .none:
            return nil
        case .called(_, let results):
            return results.last
        }
    }

    public mutating func iterate(with param: T? = nil) {
        var newIterations = 1
        var newResults: [T] = []
        if case .called(let iterations, let results) = self {
            newIterations = iterations + 1
            newResults = results
        }
        if let param = param {
            newResults.append(param)
        }
        self = .called(iterations: newIterations, results: newResults)
    }
}
