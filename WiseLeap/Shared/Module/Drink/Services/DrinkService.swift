//
//  DrinkService.swift
//  WiseLeap
//
//  Created by Kamlesh Jaiswal on 07/04/22.
//

import Foundation
import Combine

extension WebService {    
    static func getDrinks(_ searchString: String) -> AnyPublisher<DrinkResponseModel, APIError> {
        apiClient.methodPath = APIUrlConstants.searchDrinks
        let paramDict: [String: Any] = ["s" : searchString]
        return apiClient.fetch(requestType: .get, parameters: paramDict)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
