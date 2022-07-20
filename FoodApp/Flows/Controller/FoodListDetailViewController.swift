//
//  FoodListDetailViewController.swift
//  FoodApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import UIKit

class FoodListDetailViewController: UIViewController {
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var subHeadingLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var barCodeLabel: UILabel!
    @IBOutlet weak var nutrionImage: UIImageView!
    var foodItemDetail: Items?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setfoodItemDetails()
    }

    // MARK: UI UPDATION
    private func setfoodItemDetails() {
        resetAllFields()
        if let imageURLString = foodItemDetail?.packaging_photos?.ingredients?.display, !imageURLString.isEmpty {
            if let url = URL(string: imageURLString) {
                nutrionImage.kf.setImage(with: url, placeholder: UIImage(named: "food"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        headerLabel.text =  foodItemDetail?.name
        subHeadingLabel.text = foodItemDetail?.brand
        barCodeLabel.text = "\(Constants.FoodItemViewTitles.barCode) \(foodItemDetail?.barcode ?? "")"
        nameLabel.text =  "\(Constants.FoodItemViewTitles.ingredients) \(foodItemDetail?.ingredients ?? "")"
    }

    private func resetAllFields() {
        headerLabel.text =  ""
        subHeadingLabel.text = ""
        nutrionImage.image = nil
        nameLabel.text =  ""
        barCodeLabel.text = ""
    }
}
