//
//  Constants.swift
//  FoodApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import UIKit

struct Constants {
    static let api_key = "AzZMvKTAgQDEj4ogN"
    static let user_id = "fehef8w4ha"
    static let code = "0842234000988"
    struct URLString {
        static let getFoodItem = "https://chompthis.com/api/v2/food/branded/barcode.php?"
    }
    struct FoodItemCellTitles {
        static let nutrientName = "Nutrient Name:"
        static let rank = "rank:"
        static let measurement_unit = "Measurement_unit:"
    }

    struct FoodItemViewTitles {
        static let per_100g = "Per_100g:"
        static let data_points = "data_points:"
        static let description = "Description:"
    }

    struct AlertStrings {
        static let connectionErrorTitle = "Connection Failed"
        static let dataErrorTitle = "Unable To Retrieve Data"
        static let unknownErrorTitle = "Error Occured"
        static let okTitle = "Ok"
    }
    static func readFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            return nil
        }
        return nil
    }
}
