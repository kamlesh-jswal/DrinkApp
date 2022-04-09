//
//  APIUrlConstants.swift
//  Safee
//
//  Created by Kamlesh on 08/03/22.
//

import Foundation

enum APIUrlConstants {
    case searchDrinks
    case none
    
    func urlString() -> String {
        var urlString = ""
        switch self {
        case .searchDrinks:
            urlString = "1/search.php"
        case .none:
            urlString = ""
        }
        return urlString
    }
    
}
