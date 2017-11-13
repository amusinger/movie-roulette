//
//  Movie.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 10/24/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import Foundation

class Movie{
    
    var original_title: String = ""
    var overview: String = ""
    var vote_average: Float = 0.0
    var poster_path: String = ""
    var genre_ids: [Int] = []
    var genres: [String] = []
    
    public init(original_title:String, overview:String,
                vote_average:Float, poster_path:String,
                genre_ids:[Int], genres: [String]){
        self.original_title = original_title
        self.overview = overview
        self.vote_average = vote_average
        self.poster_path = poster_path
        self.genre_ids = genre_ids
        self.genres = genres
        
    }
}


