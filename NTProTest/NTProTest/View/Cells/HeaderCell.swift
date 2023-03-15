//
//  HeaderCell.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import UIKit

/// Шапка таблицы
final class HeaderCell: UITableViewHeaderFooterView {
    // MARK: - Visual components
    
    private let parametersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(parametersStackView)
        addArrangeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createStackViewAnchors()
    }
    
    // MARK: - Private methods
    
    private func addArrangeSubviews() {
        (Constants.buttonsCount).forEach { index in
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .black
            label.text = Constants.titles[index]
            parametersStackView.addArrangedSubview(label)
        }
    }
    
    private func createStackViewAnchors() {
        NSLayoutConstraint.activate([
            parametersStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            parametersStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            parametersStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            parametersStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

/// Константы
extension HeaderCell {
    enum Constants {
        static let identifier = "headerCell"
        static let titles = ["Instruments", "Price", "Amount", "Side"]
        static let buttonsCount: ClosedRange = 0...3
    }
}


