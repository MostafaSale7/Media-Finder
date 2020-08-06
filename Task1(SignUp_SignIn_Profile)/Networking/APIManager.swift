//
//  APIManager.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/7/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import Foundation
import Alamofire

class APIMangager {
    public static func loadServerMovies(completion:@escaping (_ error:Error?, _ movies:[ServerMovies]?) -> Void){
        Alamofire.request(Urls.base, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            guard response.error == nil else{
                print(response.error!.localizedDescription)
                completion(response.error, nil)
                return
            }
            guard let data = response.data else{
                completion(APIErrors.Error,nil)
                return
            }
            do{
                 let decoder = JSONDecoder()
                 let moviesArray = try decoder.decode([ServerMovies].self, from: data)
                 completion(nil, moviesArray)
            }catch{
                print(error)
            }
       }
    }
    
    public static func loadItunesSearchResult(criteria:String, mediaType:String, completion:@escaping (_ error:Error?, _ requestedMedia:[Media]?) -> Void){
        let param = ["term": criteria,
                      "media": mediaType]
        
        Alamofire.request(Urls.ituensApi, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            guard response.error == nil else {
                print(response.error!.localizedDescription)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                completion(APIErrors.Error,nil)
                return
            }
            do{
                let decoder = JSONDecoder()
                let mediaArray = try decoder.decode(MediaResponse.self, from: data).results
                completion(nil, mediaArray)
            }catch{
              print(error)
           }
        }
    }
}


