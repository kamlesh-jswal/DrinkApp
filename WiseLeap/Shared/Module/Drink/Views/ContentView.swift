//
//  ContentView.swift
//  Shared
//
//  Created by Kamlesh Jaiswal on 06/04/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var drinkVM = DrinkViewModel()
    @State private var searchText = ""
    @State var drinkSelected = false
    @State var selectedDrink: Drink?

    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing: 20) {
                    NavigationLink(destination: DrinkDetailView(drinkDetail: selectedDrink),
                                   isActive: $drinkSelected) {
                        EmptyView()
                    }
                    HStack {
                        Text("Let's eat \nQuality Food")
                            .font(.system(size: 26, weight: .bold))
                        Spacer()
                    }
                    
                    SearchBar(text: $searchText, onTextChanged: searchDrinks)
                        .padding(.trailing, 30)
                    
                    if let drinks = drinkVM.getDrinks() {
                        ScrollView(showsIndicators: false) {
                            HStack {
                                Text("Near Restaurant")
                                    .font(.system(size: 26, weight: .bold))
                                Spacer()
                                Text("See All")
                                    .font(.system(size: 20))
                            }
                            
                            VStack(spacing: 20) {
                                RestaurantCellView()
                                    .frame(height: 130)
                                    .cornerRadius(15)
                                
                                LazyVGrid(columns: columns, alignment: .center, spacing: 35) {
                                    ForEach(drinks) { drink in
                                        GridCell(drink: drink)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                drinkSelected = true
                                                selectedDrink = drink
                                            }
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding([.leading, .trailing], 20)
                .navigationBarTitleDisplayMode(.inline)
                
                ActivityIndicator(style: .large, animate:$drinkVM
                                    .isActivityIndicatorAnimate)
                    .configure{
                        $0.color = UIColor(Color.black)
                    }
            }
        }
    }
    
    func searchDrinks(for searchText: String) {
        drinkVM.getDinks(searchString: searchText)
    }
}

struct RestaurantCellView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                Image("restaurant")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150)
                    .cornerRadius(15)

                VStack(alignment: .leading) {
                    Text("Blue Restant")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Text("10.00AM - 3:30PM")
                        .font(.system(size: 18))
                        .foregroundColor(Color.gray)
                    
                    HStack {
                        Text("Steve ST Road")
                            .font(.system(size: 18))
                            .foregroundColor(Color.red)
                        
                        Spacer()
                        Text("4.5")
                            .font(.system(size: 21))
                        Image("favourite")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .padding(10)
        }
        .background(Color(hex: 0xEFEFF4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(drinkSelected: true, selectedDrink: nil)
        }
    }
}
