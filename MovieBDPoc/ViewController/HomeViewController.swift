//
//  HomeViewController.swift
//  MovieBDPoc
//
//  Created by Kavish joshi on 28/12/17.
//  Copyright © 2017 Kavish joshi. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class HomeViewController: UIViewController {
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieGridView: UICollectionView!
    
    
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var highestRatedMovieBtn: UIButton!
    @IBOutlet weak var pouplarMovieBtn: UIButton!
    
    
    
    var movieObj = [MovieEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.fetchData()
        self.initalizeUiComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true

    }
    
    //MARK:initalizeUiComponents
    func initalizeUiComponents() {
        //Collection view
        movieGridView.delegate = self
        movieGridView.dataSource = self
        
        movieGridView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        movieGridView.backgroundColor = .black

        view.addSubview(movieGridView)
        
        //Search bar
        movieSearchBar.delegate = self
        movieSearchBar.placeholder = "Search your Movie.."
        
        //highestRatedMovieBtn
        highestRatedMovieBtn.setTitle("Highest Rated", for: .normal)
        highestRatedMovieBtn.backgroundColor = .white
        highestRatedMovieBtn.layer.cornerRadius = 5
        highestRatedMovieBtn.layer.borderWidth = 1
        highestRatedMovieBtn.layer.borderColor = UIColor.black.cgColor
        highestRatedMovieBtn.setTitleColor(.black, for: .normal)
        
        //highestRatedMovieBtn
        pouplarMovieBtn.setTitle("Pouplar Movie", for: .normal)
        pouplarMovieBtn.backgroundColor = .white
        pouplarMovieBtn.layer.cornerRadius = 5
        pouplarMovieBtn.layer.borderWidth = 1
        pouplarMovieBtn.layer.borderColor = UIColor.black.cgColor
        pouplarMovieBtn.setTitleColor(.black, for: .normal)
    }
    
    //MARK: fetchData form service
    func fetchData(){
        RequestResponceHandler.shared.getMostPopularMovies { (responceDic, error, str) in
            if error == nil{
                self.movieObj = responceDic
                self.movieGridView.reloadData()
            }
        }
    }
    
    //MARK: searchMovies
    func searchMovies(searchString:String)  {
        RequestResponceHandler.shared.searchMovies(queryString: searchString) { (responceDic, error, str) in
            if error == nil{
                self.movieObj = responceDic
                self.movieGridView.reloadData()
            }
        }
    }
    
    //MARK: getTopRatedMovies
    func getTopRatedMovies()  {
        
        RequestResponceHandler.shared.topRated { (responceDic, error, str) in
            if error == nil{
                self.movieObj = responceDic
                self.movieGridView.reloadData()
            }
        }
    }
    
    @IBAction func popularMovieBtnPressed(_ sender: UIButton) {
        self.fetchData()
    }
    
    @IBAction func highRatedMovieBtnPressed(_ sender: UIButton) {
        self.getTopRatedMovies()
    }
    
}

//Search bar
extension HomeViewController:UISearchBarDelegate{
    
    //Search bar text did chnage
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text =  searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(text.count == 0) {
            self.fetchData()
        }else{
            self.searchMovies(searchString: text)
        }
        
    }
    
    //Search bar Cancel btn pressed
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.fetchData()
    }
    
}

//UICollection View delegate methods
extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieObj.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeVCCell
        
        let obj = movieObj[indexPath.row]
        
        let url = NSURL(string:AppBaseUrl.imageUrl + obj.poster_path)
        cell.imageView.af_setImage(withURL:  url! as URL)
        
        cell.movieTitleLbl.text = obj.title
        cell.movieTitleLbl.textColor = .white
        cell.movieTitleLbl.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailsViewController.movieDetailsObj = movieObj[indexPath.row]
        navigationController?.pushViewController(detailsViewController,
                                                 animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
//
//        if indexPath.row == movieObj.count-1  {
//            self.fetchData()
//        }
//    }
    
}


class HomeVCCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    
}


