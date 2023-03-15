//
//  FiltersTypes.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import Foundation

/// Типы фильтров
enum FiltersTypes {
    case date
    case instrument
    case price
    case amount
    case side
    
    enum Directions {
        case up
        case down
    }
}
