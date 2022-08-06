//
//  HomeViewModel.swift
//  Torrecats
//
//  Created by Dev IOS on 6/08/22.
//

import Foundation

class HomeViewModel:NSObject{
    
    func GetCats(completion : @escaping ([CatsModel.CatsData]?) -> ()) {
        
        HomeViewApiClient().GetCats{ response in
            
            switch response.result {
                
            case .success(_):
                
                if let Data = try? JSONDecoder().decode([CatsModel.CatsData].self, from: response.data!) as [CatsModel.CatsData]{
                    
                    completion(Data)
                    
                }else{
                    
                    completion(nil)
                    
                }
                
            case .failure(_):
                
                completion(nil)
                break
                
            }
            
        }
    }
}
