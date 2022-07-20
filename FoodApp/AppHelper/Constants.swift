//
//  Constants.swift
//  GlassWorks
//
//  Created by VenkateswaraReddy Nandipati on 05/07/22.
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
        static let description = "Description:"
        static let rank = "rank:"
    }

    struct FoodItemViewTitles {
        static let barCode = "BarCode: "
        static let ingredients = "Ingredients: "
    }

    struct AlertStrings {
        static let connectionErrorTitle = "Connection Failed"
        static let dataErrorTitle = "Unable To Retrieve Data"
        static let unknownErrorTitle = "Error Occured"
        static let okTitle = "Ok"
    }
}
