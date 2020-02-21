//
//  DataProvider.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

protocol DataProvider {
    func fetchCreditScore(completion resultHandler: @escaping (CreditScore?, DataLayerError?) -> Void)
}
