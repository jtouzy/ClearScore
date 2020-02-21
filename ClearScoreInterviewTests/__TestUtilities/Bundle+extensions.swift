//
//  Bundle+extensions.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

extension Bundle {
    func jsonData(fromFile fileName: String) -> Data? {
        guard let filePath = path(forResource: fileName, ofType: "json") else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: filePath))
    }
}
