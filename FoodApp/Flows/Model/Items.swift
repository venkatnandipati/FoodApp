//
//  Categories.swift
//  FoodApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import Foundation
import SwiftUI
struct Items: Codable {
    var name: String?
    var brand: String?
    var barcode: String?
    var ingredients: String?
    var package: Package?
    var nutrients: [Nutrients]?
    var packaging_photos: PackagingPhotos?
    private enum CodingKeys: String, CodingKey {
        case name
        case brand
        case barcode
        case ingredients
        case package
        case nutrients
        case packaging_photos
    }
}
struct Package: Codable {
    var quantity: String?
    var size: String?
    private enum Package: String, CodingKey {
        case quantity
        case size
    }
}
struct Nutrients: Codable {
    var name: String?
    var description: String?
    var rank: Int?
    private enum Nutrients: String, CodingKey {
        case name
        case description
        case rank
    }
}
struct PackagingPhotos: Codable {
    var front: Front?
    var nutrition: NutritionImage?
    var ingredients: IngredientsImage?
    private enum PackagingPhotos: String, CodingKey {
        case front
        case nutrition
        case ingredients
    }
}
struct Front: Codable {
    var small: String?
    var thumb: String?
    var display: String?
    private enum Front: String, CodingKey {
        case small
        case thumb
        case display
    }
}
struct NutritionImage: Codable {
    var small: String?
    var thumb: String?
    var display: String?
    private enum NutritionImage: String, CodingKey {
        case small
        case thumb
        case display
    }
}
struct IngredientsImage: Codable {
    var small: String?
    var thumb: String?
    var display: String?
    private enum IngredientsImage: String, CodingKey {
        case small
        case thumb
        case display
    }
}
