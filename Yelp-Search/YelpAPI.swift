//
//  YelpAPI.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/23/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation

private let baseUrl = "https://api.yelp.com"
private let clientId = "rVflb7I_OHby0hC4HcCnTA"
private let clientSecret = "4uOwRJg06iA6IBJEy61XWBwiuMJYQK59WDfQhwIUcTCY3mseU8FlGRRzcTznKyUR"
private let grantType = "client_credentials"

struct YelpAPI {
    
    // MARK: - Authentication
    
    // TODO: Fix later
    static func authenticate(_ completion: @escaping (_ success: Bool, _ message: String?) -> ()) {
        
        let parameters: [String: AnyObject] = ["client_id": clientId as AnyObject, "client_secret": clientSecret as AnyObject, "grant_type": grantType as AnyObject]
        
        post(clientURLRequest("/oauth2/token", params: parameters),
             completion: { (success, json) in
            
                // Check if there was a success
                if success {
                    
                    // Save into UserDefaults
                    UserDefaultsWrapper.setDictionary(key: "access_token", value: json as! NSDictionary)
                    
                    completion(success, "")
                } else {
                    completion(false, "")
                }
        })
    }
    
    // MARK: - Search
    
//    static func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping (_ success: Bool, _ businesses: Businesses?) ->()) {
//    
//        var parameters: [String: AnyObject] = ["term": term as AnyObject, "ll": "37.785771,-122.406165" as AnyObject]
//        
//        // Check if sort is not nil if so then set it
//        if sort != nil {
//            parameters["sort"] = sort!.rawValue as AnyObject?
//        }
//        
//        // Check if categories is not nil if so then set it 
//        if categories != nil && categories!.count > 0 {
//            parameters["category_filter"] = (categories!).joined(separator: ",") as AnyObject
//        }
//        
//        // Check if deals is not nil if so then set it
//        if deals != nil {
//            parameters["deals"] = deals! as AnyObject?
//        }
//        
//        print(parameters)
//        
//        get(clientURLRequest("/v3/businesses/search", params: parameters), completion: { (success, json) in
//         
//            if success {
//                
//                // Go ahead and wrap into Business array
//                let businesses = Businesses.from(json as! NSDictionary)
//                completion(true, businesses)
//                
//            } else {
//                
//                completion(false, nil)
//            }
//        })
//    }
    
    // MARK: - Accessory Methods
    
    static func clientURLRequest(_ path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        
        // Create the request
        let request = NSMutableURLRequest(url: URL(string: baseUrl + path)!)
        if let params = params {
            
            // Go ahead and set the parameters
            var paramString = ""
            for (key, value) in params {
                
                // Go ahead and set the escaped key and value
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
                
                // Go ahead and construct the parameter string
                paramString += "\(escapedKey)=\(value)"
            }
            
            // Magic happens here
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = paramString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        }
        
        request.addValue("Bearer " + yelpToken, forHTTPHeaderField: "Authorization")
        
        return request
    }

}

extension YelpAPI {
    
    static func post(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "POST", completion: completion)
    }
    
    static func put(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request, method: "PUT", completion: completion)
    }
    
    static func get(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) ->()) {
        dataTask(request, method: "GET", completion: completion)
    }
    
    static func delete(_ request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) ->()) {
        dataTask(request, method: "DELETE", completion: completion)
    }
    
    static func dataTask(_ request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        // Go ahead and set our method
        request.httpMethod = method
        
        let session = URLSession.shared
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            print(response.debugDescription)
            print(error.debugDescription)
            
            // Check for the data
            if let data = data {
                if let json = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    
                    print(json)
                    
                    // Check the status code and if everything checks out go ahead and pass the json through
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                        completion(true, json)
                    } else {
                        completion(false, json)
                    }
                }
            }
        }).resume()
    }

    
}
