//
//  DealsModulBuilder.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import UIKit

/// Сборщик модуля списка сделок
enum DealsModulBuilder {
    static func build() -> UIViewController {
        let view = DealsListViewController()
        let server = Server()
        let presenter = DealsPresenter(view: view, server: server)
        view.presenter = presenter
        return view
    }
}
