//
//  NetworkAPI.swift
//  Fundtastic
//
//  Created by hilmy ghozy on 06/12/21.
//

import Foundation
import Moya

enum NetworkAPI {
    case getCategory(parameter: String)
}

extension NetworkAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: ConfigKey.baseUrl.rawValue) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        
        case .getCategory:
            return ConfigKey.topHeadlines.rawValue
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    

    
    var task: Task {
        switch self {
        case .getCategory(let category):
            let parameter = ["category": category]
            return .requestParameters(parameters: parameter , encoding: URLEncoding.default)
        }
        
    }
    
    var sampleData: Data {
        switch self {
//        case .getData:
//            return Data()
        default:
            return "".utf8Encoded
        }
    }
    
    var headers: [String : String]? {
        let basicHeaders:[String:String] = ["Platform":"iOS",
                                            "X-Api-Key": ConfigKey.apiKey.rawValue,
                                            "App-Version":Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String]
        return basicHeaders
    }
}

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    func toJSON() -> [[String: Any]]? {
        guard let responseJson = try? JSONSerialization.jsonObject(with: self.utf8Encoded, options: .mutableContainers) as? [[String: Any]] else {
                return nil
            }
        
        return responseJson
    }
}
