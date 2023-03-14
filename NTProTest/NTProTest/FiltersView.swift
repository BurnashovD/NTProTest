//
//  FiltersView.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import UIKit

/// Вью с фильтрами сделок
final class FiltersView: UIView {
    // MARK: - Visual components
    
    private let filtersStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 1
        stack.alignment = .leading
        stack.distribution = .equalCentering
        return stack
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Public properties
    
    var parameterHandler: (() -> Void)?
    var dismissHandler: (() -> Void)?
    
    // MARK: - Private properties
    
    private let titles = ["Дата изменения сделки", "Имя инструмента", "Цена сделки", "Объем сделки", "Сторона сделки"]
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createStackViewAnchors()
        createDoneButtonAnchors()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        addSubviewsToStack()
        addSubview(filtersStackView)
        addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    private func addSubviewsToStack() {
        (0...4).forEach { index in
            let button = UIButton()
            button.setTitle(titles[index], for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15)
            button.setTitleColor(.black, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(changeFilterAction(sender:)), for: .touchUpInside)
            filtersStackView.addArrangedSubview(button)
        }
    }
    
    private func createDoneButtonAnchors() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            doneButton.widthAnchor.constraint(equalToConstant: 65),
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    private func createStackViewAnchors() {
        NSLayoutConstraint.activate([
            filtersStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            filtersStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            filtersStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            filtersStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        ])
    }
    
    @objc private func changeFilterAction(sender: UIButton) {
        parameterHandler?()
    }
    
    @objc private func dismissAction() {
        dismissHandler?()
    }
}
