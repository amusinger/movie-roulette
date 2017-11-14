//
//  MovieViewController.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 11/14/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController: UIViewController {
    
    var movie: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print("showmovie ", movie?.original_title)
    }
}
