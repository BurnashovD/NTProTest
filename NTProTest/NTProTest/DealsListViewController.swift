//
//  ViewController.swift
//  NTProTest
//
//  Created by Daniil on 14.03.2023.
//

import UIKit

/// Экран со списком сделок
final class DealsListViewController: UIViewController {
    
    // MARK: - Visual components
    
    private let dealsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let filtersView: FiltersView = {
        let view = FiltersView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var filterViewTopConstraint = NSLayoutConstraint()
    
    // MARK: - Private properties
    
    private let cellTypes: [CellTypes] = [.filter, .deal]

    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindFilters()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        navigationItem.title = "Deals"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(openFiltersAction))
        setupTableView()
        view.addSubview(dealsTableView)
        view.addSubview(filtersView)
        setupLayout()
    }
    
    private func setupTableView() {
        dealsTableView.delegate = self
        dealsTableView.dataSource = self
        dealsTableView.register(DealCell.self, forCellReuseIdentifier: "dealCell")
        dealsTableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.identifier)
    }
    
    private func setupLayout() {
        createTableViewAnchors()
        createFiltersViewAnchors()
    }
    
    private func bindFilters() {
        filtersView.dismissHandler = {
            self.filterViewTopConstraint.constant = 900
            UIView.animate(withDuration: 0.3) {
                self.filtersView.superview?.layoutIfNeeded()
            }
        }
        
        filtersView.parameterHandler = {
            print("Tap")
        }
    }
    
    private func createTableViewAnchors() {
        NSLayoutConstraint.activate([
            dealsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            dealsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dealsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dealsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createFiltersViewAnchors() {
        filterViewTopConstraint = filtersView.topAnchor.constraint(equalTo: view.topAnchor, constant: 900)
        NSLayoutConstraint.activate([
            filterViewTopConstraint,
            filtersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filtersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filtersView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc private func openFiltersAction() {
        filterViewTopConstraint.constant = 550
        UIView.animate(withDuration: 0.3) {
            self.filtersView.superview?.layoutIfNeeded()
        }
    }
}

/// UITableViewDelegate, UITableViewDataSource
extension DealsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = dealsTableView.dequeueReusableCell(withIdentifier: "dealCell") as? DealCell
        else { return UITableViewCell() }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.identifier) as? HeaderCell
        else { return nil }
        return cell
    }
}

private extension DealsListViewController {
    enum CellTypes {
        case filter
        case deal
    }
}
