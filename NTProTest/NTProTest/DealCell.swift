//
//  DealCell.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import UIKit

/// Ячейка со сделкой
final class DealCell: UITableViewCell {
    // MARK: - Visual components
    
    private let dealStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let instrumentNameLabel: UILabel = {
        let label = UILabel()
        label.text = "USD/RUB"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "62.10"
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "1 000 000"
        return label
    }()
    
    private let sideLabel: UILabel = {
        let label = UILabel()
        label.text = "buy"
        return label
    }()
    
    private let dealDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        label.textColor = .gray
        label.text = "28.07.2023"
        return label
    }()

    // MARK: - Public methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createStackViewAnchors()
        createDateLabelAnchors()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        addSubviewsToStack()
        contentView.addSubview(dealDateLabel)
        contentView.addSubview(dealStackView)
    }
    
    private func addSubviewsToStack() {
        dealStackView.addArrangedSubview(instrumentNameLabel)
        dealStackView.addArrangedSubview(priceLabel)
        dealStackView.addArrangedSubview(amountLabel)
        dealStackView.addArrangedSubview(sideLabel)
    }
    
    private func createDateLabelAnchors() {
        NSLayoutConstraint.activate([
            dealDateLabel.topAnchor.constraint(equalTo: dealStackView.bottomAnchor),
            dealDateLabel.leadingAnchor.constraint(equalTo: instrumentNameLabel.leadingAnchor)
        ])
    }
    
    private func createStackViewAnchors() {
        NSLayoutConstraint.activate([
            dealStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dealStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dealStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dealStackView.bottomAnchor.constraint(equalTo: dealDateLabel.topAnchor)
        ])
    }
}
