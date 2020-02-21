//
//  XCTestCase+extensions.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import XCTest

extension XCTestCase {
    func waitForRunLoop(timeout: TimeInterval) {
        let untilDate = Date(timeIntervalSinceNow: timeout)
        while (untilDate.timeIntervalSinceNow > 0) {
            RunLoop.current.run(mode: .default, before: untilDate)
        }
    }
}
