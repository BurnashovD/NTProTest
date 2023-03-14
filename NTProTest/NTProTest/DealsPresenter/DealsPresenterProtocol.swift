//
//  DealsPresenterProtocol.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import Foundation

/// Протокол презентера экрана списка сделок
protocol DealsPresenterProtocol {
    var deals: [Deal] { get set }
    var currentFilter: FiltersTypes { get set }
    var currentDirection: FiltersTypes.Directions { get set }
    func fetchDeals()
}
