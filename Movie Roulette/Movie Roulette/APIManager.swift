//
//  APIManager.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 10/24/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import Foundation
import Alamofire

public typealias CompletionClosure = (_ hello: AnyObject) -> Void
public typealias GenreCompletionClosure = (_ hello: [Genre]) -> Void

public class APIManager : NSObject {
    class func getMovies(Closure: @escaping CompletionClosure){
        Alamofire.request("https://api.themoviedb.org/3/discover/movie?api_key=fdb71b71a3f81a50e5e963e5e0720fe7&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&vote_average.gte=6&year=2017").responseJSON { response in
            //debugPrint(response)
            
            if let json = response.result.value {
                let result = json as! [String: Any]
                let movies = result["results"] as? [Any]
                let random = Int(arc4random_uniform(10))
                let d = movies![random] as AnyObject
                
                let randomMovie = Movie(original_title: d["original_title"] as! String, overview: d["overview"] as! String, vote_average: d["vote_average"] as! Float, poster_path: d["poster_path"] as! String, genre_ids: d["genre_ids"] as! [Int], genres: [])
               
                //self.getGenres(genre_ids: d["genre_ids"] as! [Int])
                Closure(randomMovie)
            }
        }
    }
    class func getGenres(Closure: @escaping GenreCompletionClosure){
        Alamofire.request("https://api.themoviedb.org/3/genre/movie/list?api_key=fdb71b71a3f81a50e5e963e5e0720fe7&language=en-US").responseJSON { response in
            //debugPrint(response)
            var genres:[Genre] = []
            if let json = response.result.value {
                let res = json as! [String: Any]
                let result = res["genres"] as? [Any]
                
                for item in result!{
                    let g = item as AnyObject
                    let genreItem = Genre(id: g["id"] as! Int, name: g["name"] as! String)
                    genres.append(genreItem)
                }
                Closure(genres)
               
            }
        }
    }
  
}

