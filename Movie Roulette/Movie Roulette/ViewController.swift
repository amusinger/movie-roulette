//
//  ViewController.swift
//  Movie Roulette
//
//  Created by Aizhan Yerimbetova on 10/23/17.
//  Copyright © 2017 Aizhan Yerimbetova. All rights reserved.
//

import UIKit
public typealias CompletionClosure = (_ res: AnyObject?) -> Void
class ViewController: UIViewController {
    
    
   
    @IBOutlet weak var pickGenreTextField: UITextField!
    
    //    @IBOutlet weak var genrePicker: UIPickerView!
    var randomMovie: Movie? = nil
    var genres: [Genre] = []
    var year = "2017"
    var score = "5"
    var genre = ""
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var pickerDataSource: [String] =  ["Random"]
    //    {
    //        didSet {
    //            genrePicker.reloadAllComponents()
    //        }
    //    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //        genrePicker.delegate=self
        //        genrePicker.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.getGenres() { (success) -> Void in
            if success {
                self.createGenrePicker()
                self.createToolbar()
                // do second task if success
                
                //                print(self.pickerDataSource)
            }
            else{
                print("didn't get genres: smth went wrong")
                self.reset()
            }
        }
        
        
        //print("after getGenres ", self.randomMovie?.original_title as Any)
    }
    func createGenrePicker(){
        let genrePicker = UIPickerView()
        genrePicker.delegate = self
        
        pickGenreTextField.inputView = genrePicker
        
        //customization
        genrePicker.backgroundColor = .black
        
    }
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //customization
        toolbar.barTintColor = .black
        toolbar.tintColor = .white
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        pickGenreTextField.inputAccessoryView = toolbar
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func getGenres(completion: @escaping (_ success: Bool) -> Void){
        APIManager.getGenres(){
            (result) in
            self.genres = result
            if(!self.genres.isEmpty){
                for i in self.genres{
                    self.pickerDataSource.append(i.name)
                }
                completion(true)
            }
            else{
                completion(false)
            }
            
            //            self.pressButton() //remove later
        }
    }
    

    @IBAction func pressButton(_ sender: UIButton) {
        if(!self.genres.isEmpty){
            self.activityLoader()
            self.fetchMovie { (success) -> Void in
                if success {
                    // do second task if success
                    print("heeeeeeeeeey")
                    self.showMovie()
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                else{
                    print("smth went wrong")
                    self.reset()
                }
            }
        }
        else{
            print("couldn't load genres")
        }
    }
    
    
    func reset(){
        self.year = ""
        self.score = ""
        self.genre = ""
    }
    
    func activityLoader(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func fetchMovie(completion: @escaping (_ success: Bool) -> Void) {
        // Do something
        APIManager.getMovies(year: year, score: score, genre: genre, genres: self.genres) {
            (result) in
            self.randomMovie = result as? Movie
            print("findMovie ", self.randomMovie?.original_title as Any)
            if((self.randomMovie != nil) && (!self.genres.isEmpty)){
                // self.matchMoviewWithGenres()
                print("findMovie return", self.randomMovie?.original_title as Any)
                
                for genre in self.genres{
                    for id in (self.randomMovie?.genre_ids)!{
                        if(genre.id == id){
                            self.randomMovie?.genres.append(genre.name)
                        }
                    }
                }
                completion(true)
            }
            if(self.randomMovie == nil){
                print("request is too unique like you")
                completion(false)
            }
            
        }
        
        completion(false)
    }
    
    func showMovie(){
        print("-------second task------")
        print(self.randomMovie?.original_title)
        //        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
        //        VC.movie = self.randomMovie
        //        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    //    func matchMoviewWithGenres(){
    //        for genre in self.genres{
    //            for id in (self.randomMovie?.genre_ids)!{
    //                if(genre.id == id){
    //                    self.randomMovie?.genres.append(genre.name)
    //                    print("matchMoviewWithGenres ", self.randomMovie?.genres as Any)
    //
    //                }
    //            }
    //        }
    //
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerDataSource[row])
        for i in self.genres{
            if(pickerDataSource[row] == i.name){
                self.genre = String(i.id)
            }
        }
        pickGenreTextField.text = pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel{
            label = view
        } else{
            label = UILabel()
        }
        label.textColor = .green
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 17)
        
        label.text = pickerDataSource[row]
        return label
    }
}

