//
//  DrinkResponseModel.swift
//  WiseLeap
//
//  Created by Kamlesh Jaiswal on 06/04/22.
//

import Foundation

struct DrinkResponseModel: Decodable {
    let drinks: [Drink]
}

struct Drink: Decodable, Identifiable {
    let id = UUID()
    let strDrinkThumb: String?
    let strDrink: String?
    let strCategory: String?
    let idDrink: String?
    
    let strInstructions: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?

    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
}
