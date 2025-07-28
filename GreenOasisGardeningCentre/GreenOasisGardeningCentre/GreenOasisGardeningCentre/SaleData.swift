//
//  SaleData.swift
//  GreenOasisGardeningCentre
//
//  Created by Daniel Sergeev on 18/5/2025.
//

import Foundation

// retrieves JSON file from online source
struct SaleItems: Codable
{
    let productName: String
    let description: String
    let wasPrice: Double
    let nowPrice: Double
    let image: String //uses sf symbols as images
}

// used for creating shopping list report
struct ShoppingReportItem: Identifiable, Codable
{
    let id = UUID()
    let name: String
    let quantity: Int
    let totalPrice: Double
}



// Saves report
func saveShoppingReports(_ reports: [ShoppingReportItem]) {
    if let encoded = try? JSONEncoder().encode(reports) {
        UserDefaults.standard.set(encoded, forKey: "shoppingReports")
    }
}

// Loads report to allow viewing
func loadShoppingReports() -> [ShoppingReportItem] {
    if let savedReports = UserDefaults.standard.data(forKey: "shoppingReports"),
       let decodedReports = try? JSONDecoder().decode([ShoppingReportItem].self, from: savedReports) {
        return decodedReports
    }
    return []
}
