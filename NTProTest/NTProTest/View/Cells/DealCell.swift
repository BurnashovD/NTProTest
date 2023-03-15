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
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let sideLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let dealDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        label.textColor = .gray
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
    
    func configure(deal: Deal) {
        instrumentNameLabel.text = deal.instrumentName
        priceLabel.text = String(format: Constants.twoSymbolsStringFormat, deal.price)
        amountLabel.text = String(format: Constants.zeroSymbolsStringFormat, deal.amount)
        sideLabel.text = convertSide(side: deal.side)
        sideLabel.textColor = sideLabelColor(side: deal.side)
        dealDateLabel.text = "\(deal.dateModifier.formatted(.dateTime))"
        priceLabel.textColor = sideLabelColor(side: deal.side)
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        addSubviewsToStack()
        contentView.addSubview(dealDateLabel)
        contentView.addSubview(dealStackView)
    }
    
    private func convertSide(side: Deal.Side) -> String {
        switch side {
        case .buy:
            return Constants.butText
        case .sell:
            return Constants.sellText
        }
    }
    
    private func sideLabelColor(side: Deal.Side) -> UIColor {
        switch side {
        case .buy:
            return .green
        case .sell:
            return .red
        }
    }
    
    private func addSubviewsToStack() {
        dealStackView.addArrangedSubview(instrumentNameLabel)
        dealStackView.addArrangedSubview(priceLabel)
        dealStackView.addArrangedSubview(amountLabel)
        dealStackView.addArrangedSubview(sideLabel)
    }
    
    private func createDateLabelAnchors() {
        NSLayoutConstraint.activate([
            dealDateLabel.topAnchor.constraint(equalTo: dealStackView.bottomAnchor, constant: 5),
            dealDateLabel.leadingAnchor.constraint(equalTo: instrumentNameLabel.leadingAnchor),
            dealDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createStackViewAnchors() {
        NSLayoutConstraint.activate([
            dealStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dealStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dealStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            dealStackView.bottomAnchor.constraint(equalTo: dealDateLabel.topAnchor, constant: -5)
        ])
    }
}

/// Константы
private extension DealCell {
    enum Constants {
        static let butText = "buy"
        static let sellText = "sell"
        static let twoSymbolsStringFormat = "%.2f"
        static let zeroSymbolsStringFormat = "%.0f"
    }
}
