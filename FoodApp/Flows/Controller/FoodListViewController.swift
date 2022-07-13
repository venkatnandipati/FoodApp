//
//  FoodListViewController.swift
//  FoodApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import UIKit

private struct FoodListPrivateContants {
    static let foodCellIdentifier = "foodItemCell"
    static let foodListCellNibName = "FoodItemTableViewCell"
    static let defaultCellHeight = 60.0
}
class FoodListViewController: UIViewController {
    private var arrFoodItems: [Items]?
    @IBOutlet weak private var foodListTableView: UITableView!
    lazy var viewModel: FoodListViewProtocol = {
        FoodListViewModel.init(newFoodItemListServiceRequestor: FoodItemServiceRequestor())
    }() as FoodListViewProtocol
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseTableViewComponents()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchFoodItems()
        didReceiveFoodItemData()
        foodItemListDidFailWithError()
    }
    // MARK: Definng UI Components
    private func initialiseTableViewComponents() {
        foodListTableView.estimatedRowHeight = FoodListPrivateContants.defaultCellHeight
        foodListTableView.rowHeight = UITableView.automaticDimension
        foodListTableView.tableFooterView = UIView(frame: .zero)
        registerNibs()
    }
    private func registerNibs() {
        let itemsCellNib = UINib(nibName: FoodListPrivateContants.foodListCellNibName, bundle: nil)
        foodListTableView!.register(itemsCellNib, forCellReuseIdentifier: FoodListPrivateContants.foodCellIdentifier)
    }
}
extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFoodItems?[0].nutrients?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FoodItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: FoodListPrivateContants.foodCellIdentifier, for: indexPath) as?  FoodItemTableViewCell, let items = arrFoodItems else {
            return UITableViewCell()
        }
        let itemsData = (items[0].nutrients?[indexPath.item])!
        cell.setupData(itemsData: itemsData, package: items[0])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFoodItem = arrFoodItems?[0]
        let foodListDetailView: FoodListDetailViewController =  mainStoryboard().instantiate()
        foodListDetailView.foodItemDetail = selectedFoodItem
        navigationController?.pushViewController(foodListDetailView, animated: true)
    }
}
extension FoodListViewController {
    // MARK: - View Model Call Backs
    private func didReceiveFoodItemData() {
        // Reload TableView closure
        viewModel.reloadFoodItemsList = { [weak self] (foodItems) in
            Task {[weak self] in
                self?.arrFoodItems = foodItems
                self?.foodListTableView.reloadData()
            }
        }
    }
    private func foodItemListDidFailWithError() {
        // Show network error message
        viewModel.showDataFetchError = { [weak self] error in
            Task { [weak self] in
                self?.showErrorAlertForFoodItemList(error: error)
            }
        }
    }
    private func fetchFoodItems() {
        // Get news data from VM
        Task { [weak self] in
            await self?.viewModel.getFoodItemsList()
        }
    }
}
extension FoodListViewController {
    func showErrorAlertForFoodItemList(error: Error?) {
        guard let err = error else { return }
        if let customError = err as? CustomError {
            switch customError {
            case .connectionFailed:
                AlertHandler.showAlert(forMessage: customError.errorMessage, title: Constants.AlertStrings.connectionErrorTitle, defaultButtonTitle: Constants.AlertStrings.okTitle, sourceViewController: self)
            case .dataError:
                AlertHandler.showAlert(forMessage: customError.errorMessage, title: Constants.AlertStrings.connectionErrorTitle, defaultButtonTitle: Constants.AlertStrings.okTitle, sourceViewController: self)
            case .unexpected:
                AlertHandler.showAlert(forMessage: customError.errorMessage, title: Constants.AlertStrings.connectionErrorTitle, defaultButtonTitle: Constants.AlertStrings.okTitle, sourceViewController: self)
            }
        }
    }
}
