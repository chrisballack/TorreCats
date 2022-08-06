//
//  HomeViewApiClient.swift
//  Torrecats
//
//  Created by Dev IOS on 6/08/22.
//

import Foundation
import Alamofire

class HomeViewApiClient{
    
    func GetCats(completion : @escaping (AFDataResponse<Data>) -> ()){
        
        AF.request(Domain+GetsURL.GetCats, method: .get).responseData { Result in
            
            completion(Result)
            
        }
        
    }
    
}
