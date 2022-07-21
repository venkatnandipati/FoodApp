//
//  FoodListDetailViewController.swift
//  FoodApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import UIKit

class FoodDetailViewController: UIViewController {
    @IBOutlet private(set) weak var dataPointsLabelLabel: UILabel!
    @IBOutlet private weak var per100gLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    var foodNutrientDetail: Nutrients?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setfoodItemDetails()
    }

    // MARK: UI UPDATION
    private func setfoodItemDetails() {
        resetAllFields()
        nameLabel.text =  foodNutrientDetail?.name
        per100gLabel.text = "\(Constants.FoodItemViewTitles.per_100g) \(foodNutrientDetail?.per100g ?? 0)"
        dataPointsLabelLabel.text = "\(Constants.FoodItemViewTitles.data_points) \(foodNutrientDetail?.dataPoints ?? 0)"
        descriptionLabel.text = "\(Constants.FoodItemViewTitles.description) \(foodNutrientDetail?.description ?? "")"

    }

    private func resetAllFields() {
        nameLabel.text =  ""
        per100gLabel.text = ""
        dataPointsLabelLabel.text =  ""
        descriptionLabel.text = ""
    }
}
