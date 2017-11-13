//
//  ViewController.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 10/23/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var randomMovie: Movie? = nil
    var genres: [Genre] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var year = 2016
        var score = 6
        var genre = ""
        
        APIManager.getGenres(){
            (result) in
            self.genres = result
           
            self.matchMoviewWithGenres()
        }
        APIManager.getMovies {
            (result) in
            self.randomMovie = result as? Movie
            
        }
//        if((self.randomMovie != nil) && (!self.genres.isEmpty)){
        
//        }
  
       
    }
    func matchMoviewWithGenres(){
        for genre in self.genres{
            for id in (self.randomMovie?.genre_ids)!{
                if(genre.id == id){
                    self.randomMovie?.genres.append(genre.name)
                }
            }
        }       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

