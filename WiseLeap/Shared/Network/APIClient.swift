//
//  APIClient.swift
//  Shafee
//
//  Created by Kamlesh on 08/03/22.
//

import Foundation
import Foundation
import Combine

let kContentTypeKey      = "Content-Type"
let kContentTypeValue    = "application/json"

enum APIError: Error, LocalizedError {
    case unknown
    case apiError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Something went wrong"
        case .apiError(let reason):
            return reason
        }
    }
}

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
}

enum WebService {
    static var apiClient = APIClient()
}

struct Response<T> {
    let value: T
    let response:URLResponse
}


struct APIClient {
    
    var methodPath: APIUrlConstants = .none
    
    var url: String {
            let serverUrl = "https://thecocktaildb.com/api/json/v1/"
            let url = serverUrl + methodPath.urlString()
            return url
    }
    
    func fetch<T: Decodable>(_ retryCount: Int = 0, requestType: HTTPMethod,
                             parameters: [String: Any]?) -> AnyPublisher<Response<T>, APIError> {
        
        let start = DispatchTime.now()
            
        let endPoint = URL(string: url)!
        var request = NSMutableURLRequest(url: endPoint)
        
        if let parametersObj = parameters {
            if requestType == .get {
                let paramDict = parametersObj
                let urlStr: String =  "\(url)" + "\(parameterString(dict: paramDict))"
                print(urlStr)
                request = NSMutableURLRequest(url: URL(string: urlStr)!)
                
            } else {
                 
                let paramDict = parametersObj
                if !paramDict.isEmpty {
                    let jsonData = try? JSONSerialization.data(withJSONObject: paramDict, options: [])
                    request.httpBody = jsonData
                }
            }
        }
        request.httpMethod = requestType.rawValue
        request.setValue(kContentTypeValue, forHTTPHeaderField: kContentTypeKey)
        
        
        return URLSession.DataTaskPublisher(request: request as URLRequest, session: .shared)
            .tryMap { result -> Response<T> in
                if let httpResponse = result.response as? HTTPURLResponse {
                    print("httpResponse: ", httpResponse)
                    if 200..<300 ~= httpResponse.statusCode {
                        
                    } else {
                        throw APIError.unknown
                    }
                } else {
                    throw APIError.unknown
                }
                
                let end = DispatchTime.now()
                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests

                print("Time to execute api: \(endPoint): \(timeInterval) seconds")
                let value = try JSONDecoder().decode(T.self, from: result.data) // 4
                let response = Response(value: value, response: result.response)
                return response
            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func parameterString(dict: [String: Any]) -> String {
        
        var parts: [String] = []
        for (key, value) in dict {
            
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters:
                                                                                .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters:
                                                                                .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return String(format: "?%@", parts.joined(separator: "&"))
    }
}
