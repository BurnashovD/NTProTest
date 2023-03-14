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
        stack.alignment = .leading
        stack.distribution = .equalCentering
        return stack
    }()
    
    private let filterDirectionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
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
    
    var parameterHandler: ((FiltersTypes) -> Void)?
    var directionHandler: ((FiltersTypes.Directions) -> Void)?
    var dismissHandler: (() -> Void)?
    
    // MARK: - Private properties
    
    private let titles = ["Дата изменения сделки", "Имя инструмента", "Цена сделки", "Объем сделки", "Сторона сделки"]
    private let directionButtonsImageNames = ["chevron.up", "chevron.down"]
    
    private var filtersButtons: [UIButton] = []
    private var previousButtonTag = 0
    
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
        createDirectionStackViewAnchors()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        addSubviewsToFiltersStack()
        addSubviewsToDirectionStack()
        addSubview(filtersStackView)
        addSubview(doneButton)
        addSubview(filterDirectionStackView)
        doneButton.addTarget(self, action: #selector(hideFiltersViewAction), for: .touchUpInside)
    }
    
    private func addSubviewsToFiltersStack() {
        (0...4).forEach { index in
            let button = UIButton()
            button.setTitle(titles[index], for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15)
            button.setTitleColor(index == 0 ? .tintColor : .black, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(changeFilterAction(sender:)), for: .touchUpInside)
            filtersButtons.append(button)
            filtersStackView.addArrangedSubview(button)
        }
    }
    
    private func addSubviewsToDirectionStack() {
        (0...1).forEach { index in
            let button = UIButton()
            button.setImage(UIImage(systemName: directionButtonsImageNames[index]), for: .normal)
            button.tintColor = .tintColor
            button.tag = index
            button.addTarget(self, action: #selector(changeFilterDirectionAction(sender:)), for: .touchUpInside)
            filterDirectionStackView.addArrangedSubview(button)
        }
    }
    
    private func createDoneButtonAnchors() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            doneButton.widthAnchor.constraint(equalToConstant: 65),
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    private func createDirectionStackViewAnchors() {
        NSLayoutConstraint.activate([
            filterDirectionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            filterDirectionStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            filterDirectionStackView.heightAnchor.constraint(equalToConstant: 100),
            filterDirectionStackView.widthAnchor.constraint(equalToConstant: 100)
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
    
    @objc private func changeFilterDirectionAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            directionHandler?(.up)
        case 1:
            directionHandler?(.down)
        default:
            break
        }
    }
    
    @objc private func changeFilterAction(sender: UIButton) {
        filtersButtons[previousButtonTag].setTitleColor(.black, for: .normal)
        sender.setTitleColor(.tintColor, for: .normal)
        previousButtonTag = sender.tag
        switch sender.tag {
        case 0:
            parameterHandler?(.date)
        case 1:
            parameterHandler?(.instrument)
        case 2:
            parameterHandler?(.price)
        case 3:
            parameterHandler?(.amount)
        case 4:
            parameterHandler?(.side)
        default:
            break
        }
    
    }
    
    @objc private func hideFiltersViewAction() {
        dismissHandler?()
    }
}
