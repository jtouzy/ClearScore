//
//  JSONDecoder+extensions.swift
//  ClearScoreInterviewTests
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, fromFile fileName: String) -> T where T: Decodable {
        let bundle = Bundle(for: HTTPDataProviderTests.self)
        guard
            let fileData = bundle.jsonData(fromFile: fileName),
            let deserializedJson = try? decode(T.self, from: fileData)
        else {
            fatalError("Can't build test data. Please check your configuration.")
        }
        return deserializedJson
    }
}
