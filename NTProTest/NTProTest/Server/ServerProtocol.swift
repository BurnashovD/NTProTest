//
//  ServerProtocol.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import Foundation

/// Протокол сервера
protocol ServerProtocol {
    func subscribeToDeals(callback: @escaping ([Deal]) -> Void)
}
