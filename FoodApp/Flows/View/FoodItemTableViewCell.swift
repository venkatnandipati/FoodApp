//
//  FoodItemTableViewCell.swift
//  FoosApp
//
//  Created by VenkateswaraReddy Nandipati on 11/07/22.
//

import UIKit
import Kingfisher

class FoodItemTableViewCell: UITableViewCell {
    @IBOutlet weak private (set) var lblName: UILabel!
    @IBOutlet weak private var lblRank: UILabel!
    @IBOutlet weak private var lblmeasurementUnitName: UILabel!
    @IBOutlet weak private var frontImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupData(itemsData: Nutrients, package: Items) {
        lblName.text = "\(Constants.FoodItemCellTitles.nutrientName) \(itemsData.name ?? "")"
        lblRank.text = "\(Constants.FoodItemCellTitles.rank) \(itemsData.rank ?? 0)"
        lblmeasurementUnitName.text = "\(Constants.FoodItemCellTitles.measurement_unit) \(itemsData.measurementUnit ?? "Not Available")"
        if let imageURLString = package.packaging_photos?.front?.small, !imageURLString.isEmpty {
            if let url = URL(string: imageURLString) {
                frontImage.kf.setImage(with: url, placeholder: UIImage(named: "Nutrients"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
}
