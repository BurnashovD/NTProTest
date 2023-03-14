//
//  DealsRouter.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import UIKit

/// Роутер экрана списка сделок
final class DealsRouter: Routable {
    // MARK: - Private properties
    
    private var navigationController: UINavigationController?
    
    // MARK: - init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func initialVC() {
        guard
            let navigationController = navigationController
        else { return }
        let dealsModul = DealsModulBuilder.build()
        navigationController.pushViewController(dealsModul, animated: true)
    }
}
