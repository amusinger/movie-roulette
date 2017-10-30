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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIManager.getMovies {
            (result) in
            self.randomMovie = result as? Movie

            print(self.randomMovie?.overview)
            
            
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

