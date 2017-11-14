//
//  APIManager.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 10/24/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import Foundation
import Alamofire


public typealias GenreCompletionClosure = (_ res: [Genre]) -> Void

public class APIManager : NSObject {
    
    class func getMovies(year:String, score:String, genre:String, genres:[Genre], Closure: @escaping CompletionClosure){
        
        var selectedYear = year
        var selectedScore = score
        var selectedGenre = genre
        
        if(selectedYear == ""){
            let x = Int(arc4random_uniform(2017 - 1950) + 1950)
            selectedYear = String(x)
            print("year ", selectedYear)
        }
        if(selectedScore == ""){
            selectedScore = String(Int(arc4random_uniform(10 - 5) + 5))
            print("score ", selectedScore)
        }
        if(selectedGenre == ""){
            let random = Int(arc4random_uniform(UInt32(genres.count-1)))
            let randomGenre = genres[random]
            
            print(randomGenre.name)
            selectedGenre = String(randomGenre.id)
           
        }
        
        print(selectedYear, selectedScore, selectedGenre)
        let parameters: Parameters =
            [
                "api_key":"fdb71b71a3f81a50e5e963e5e0720fe7",
                "language":"en-US",
                "sort_by":"popularity.desc",
                "include_adult":false,
                "include_video":true,
                "page":1,
                "year": selectedYear,
                "vote_average.gte": selectedScore,
                "with_genres": selectedGenre
            ]
        var randomMovie: Movie? = nil
        Alamofire.request("https://api.themoviedb.org/3/discover/movie?", parameters: parameters).responseJSON { response in
            //debugPrint(response)
            switch response.result {
            case .success:
                let json = response.result.value
                let result = json as! [String: Any]
                let total = result["total_results"] as! Int
                if(total  > 0){
                    let movies = result["results"] as? [Any]
                    let d = movies![0] as AnyObject
                    
                    randomMovie = Movie(original_title: d["title"] as! String, overview: d["overview"] as! String, vote_average: d["vote_average"] as! Float, poster_path: d["poster_path"] as! String, genre_ids: d["genre_ids"] as! [Int], genres: [])
                    
                    //self.getGenres(genre_ids: d["genre_ids"] as! [Int])
//                    print(randomMovie.original_title)
                    Closure(randomMovie!)
                }
                else{
                   
                    Closure(nil)
                }
                
                
                
            case .failure(let error):
                print(error)
            }
            
    
        }
    }
    class func getGenres(Closure: @escaping GenreCompletionClosure){
        Alamofire.request("https://api.themoviedb.org/3/genre/movie/list?api_key=fdb71b71a3f81a50e5e963e5e0720fe7&language=en-US").responseJSON { response in
           // debugPrint(response)
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

