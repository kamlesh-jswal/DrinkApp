//
//  DrinkViewModel.swift
//  WiseLeap
//
//  Created by Kamlesh Jaiswal on 06/04/22.
//

import Foundation
import Combine

class DrinkViewModel: ObservableObject {
    
    @Published var isActivityIndicatorAnimate = false
    var orderHistoryModel: DrinkResponseModel?

    private var cancellationToken: AnyCancellable?
    
    func getDinks(searchString: String) {
        isActivityIndicatorAnimate = true
        self.cancellationToken = WebService.getDrinks(searchString)
            .sink(receiveCompletion: { completion in
                self.isActivityIndicatorAnimate = false
                switch completion {
                case .finished:
                    break
                case .failure(.unknown):
                    self.isActivityIndicatorAnimate = false
                    self.orderHistoryModel = nil

                case .failure(_):
                    self.isActivityIndicatorAnimate = false
                    self.orderHistoryModel = nil
                }
            }, receiveValue: { data in
                self.isActivityIndicatorAnimate = false
                self.orderHistoryModel = data
            })
    }
        
    func getDrinks() -> [Drink]? {
        self.orderHistoryModel?.drinks
    }
    
}
