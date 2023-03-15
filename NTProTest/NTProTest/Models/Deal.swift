//
//  Deal.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import Foundation

/// Сделка
struct Deal {
    /// Идентификатор
    let id: Int64
    /// Дата сделки
    let dateModifier: Date
    /// Название инструмента
    let instrumentName: String
    /// Цена
    let price: Double
    /// Объем
    let amount: Double
    /// Сторона
    let side: Side
    
    enum Side: CaseIterable {
        case sell, buy
    }
}
