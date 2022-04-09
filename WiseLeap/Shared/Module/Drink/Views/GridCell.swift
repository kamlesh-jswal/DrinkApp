//
//  GridCell.swift
//  WiseLeap
//
//  Created by Kamlesh Jaiswal on 06/04/22.
//

import SwiftUI

struct GridCell: View {
    let drink: Drink
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                if let thumbURL = URL(string: drink.strDrinkThumb ?? "") {
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
                    .cornerRadius(15)
                }
                                
                VStack(alignment: .leading, spacing: 2) {
                    Text(drink.strDrink ?? "")
                        .font(.system(size: 19, weight: .bold))
                    Text(drink.strCategory ?? "")
                        .font(.system(size: 16))
                    
                    HStack {
                        Text("$10.00")
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                        
                        Spacer()
                        Text("View")
                            .font(.system(size: 18))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                            .foregroundColor(Color.red)
                    }
                }
            }
        }
    }
}
