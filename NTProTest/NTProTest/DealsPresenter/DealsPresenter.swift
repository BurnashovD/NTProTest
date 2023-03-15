//
//  DealsPresenter.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import Foundation

/// Презентер экрана со сделками
final class DealsPresenter: DealsPresenterProtocol {
    // MARK: - Public properties
    
    var deals: [Deal] = []
    var currentFilter: FiltersTypes = .date
    var currentDirection: FiltersTypes.Directions = .down
    
    // MARK: - Private properties
    
    private weak var view: DealsViewProtocol?
    private var server: ServerProtocol?
    
    // MARK: - init
    
    init(view: DealsViewProtocol, server: ServerProtocol) {
        self.view = view
        self.server = server
    }
    
    // MARK: - Public methods
    
    func fetchDeals() {
        server?.subscribeToDeals(callback: { [weak self] deals in
            guard let self = self else { return }
            self.deals.append(contentsOf: deals)
            self.sortDeals(filter: self.currentFilter, direction: self.currentDirection)
        })
    }
    
    func sortDeals(filter: FiltersTypes, direction: FiltersTypes.Directions) {
        let queue = DispatchQueue(label: Constants.sortQueueLabel)
        queue.async {
            switch filter {
            case .date:
                self.deals.sort {
                    direction == .up ? $0.dateModifier < $1.dateModifier : $0.dateModifier > $1.dateModifier
                }
            case .side:
                self.deals.sort {
                    direction == .up ? $0.side.hashValue < $1.side.hashValue : $0.side.hashValue > $1.side.hashValue
                }
            case .amount:
                self.deals.sort {
                    direction == .up ? $0.amount < $1.amount : $0.amount > $1.amount
                }
            case .price:
                self.deals.sort {
                    direction == .up ? $0.price < $1.price : $0.price > $1.price
                }
            case .instrument:
                self.deals.sort {
                    direction == .up ? $0.instrumentName < $1.instrumentName : $0.instrumentName > $1.instrumentName
                }
            }
            DispatchQueue.main.async {
                self.view?.loadDeals()
            }
        }
    }
}

/// Константы
private extension DealsPresenter {
    enum Constants {
        static let sortQueueLabel = "sortQueue"
    }
}

