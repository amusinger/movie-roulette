//
//  WatchlistViewController.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 11/14/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import Foundation
import UIKit

class WatchlistViewController: UIViewController {
    
//    var userdefaults = UserDefaults.standardUserDefaults
//    var moviesToWatch: [Movie] = userdefaults.objectForKey("key") as NSArray
    
    
    var moviesToWatch: [Movie] = []
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserDefaults.standard.set(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
//        
//        let movies = UserDefaults.standard.value(forKey: <#T##String#>) 
//    
        
        
        moviesToWatch.append(movie)
        self.save()
    }
    
    func save(){
       
//        userdefaults.setObject(moviesToWatch, forKey: "key")
//        userdefaults.synchronize()
    }
}
