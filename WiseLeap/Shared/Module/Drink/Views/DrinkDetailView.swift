//
//  DrinkDetailView.swift
//  WiseLeap
//
//  Created by Kamlesh Jaiswal on 07/04/22.
//

import SwiftUI

struct DrinkDetailView: View {
    let drinkDetail: Drink?
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    if let thumbURL = URL(string: drinkDetail?.strDrinkThumb ?? "") {
                        AsyncImage(
                            url: thumbURL,
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            },
                            placeholder: {
                                ProgressView()
                                    .frame(width: 150, height: 150)
                            }
                        )
                            .scaledToFill()
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        if let instruction = drinkDetail?.strInstructions {
                            Text(instruction)
                                .font(.system(size: 19))
                        }
                        
                        if let category = drinkDetail?.strCategory {
                            Text(category)
                                .font(.system(size: 16))
                                .foregroundColor(Color.gray)
                        }
                        
                        Divider()
                        
                        Text("Ingredient")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.black)
                            .underline()
                        
                        if let ingredient = drinkDetail?.strIngredient1,
                           let measure = drinkDetail?.strMeasure1 {
                            HStack {
                                Text(ingredient)
                                    .font(.system(size: 16))
                                Spacer()
                                Text(measure)
                                    .font(.system(size: 16))
                            }
                        }
                        
                        if let ingredient = drinkDetail?.strIngredient2,
                           let measure = drinkDetail?.strMeasure2 {
                            HStack {
                                Text(ingredient)
                                    .font(.system(size: 16))
                                Spacer()
                                Text(measure)
                                    .font(.system(size: 16))
                            }
                        }
                        
                        if let ingredient = drinkDetail?.strIngredient3,
                           let measure = drinkDetail?.strMeasure3 {
                            HStack {
                                Text(ingredient)
                                    .font(.system(size: 16))
                                Spacer()
                                Text(measure)
                                    .font(.system(size: 16))
                            }
                        }
                        
                        if let ingredient = drinkDetail?.strIngredient4,
                           let measure = drinkDetail?.strMeasure4 {
                            HStack {
                                Text(ingredient)
                                    .font(.system(size: 16))
                                Spacer()
                                Text(measure)
                                    .font(.system(size: 16))
                            }
                        }
                        
                        if let ingredient = drinkDetail?.strIngredient5,
                           let measure = drinkDetail?.strMeasure5 {
                            HStack {
                                Text(ingredient)
                                    .font(.system(size: 16))
                                Spacer()
                                Text(measure)
                                    .font(.system(size: 16))
                            }
                        }
                    }
                    .padding([.horizontal, .bottom], 20)
                }
            }
        }
        .background(Color.white)
    }
}
