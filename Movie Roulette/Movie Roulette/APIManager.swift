//
//  APIManager.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 10/24/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import Foundation
import Alamofire

public typealias CompletionClosure = (_ hello: Any) -> Void

public class APIManager : NSObject {
    class func getMovies(Closure: @escaping CompletionClosure){
        Alamofire.request("https://api.themoviedb.org/3/discover/movie?api_key=fdb71b71a3f81a50e5e963e5e0720fe7&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                let result = json
                Closure(result)
            }
        }
    }
  
}

