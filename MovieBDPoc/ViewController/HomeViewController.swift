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
        view.addSubview(movieGridView)
        
        //Search bar
        movieSearchBar.delegate = self
        
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
    
}

//Search bar
extension HomeViewController:UISearchBarDelegate{
    
    //Search bar text did chnage
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var text =  searchBar.text
        text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(text?.count == 0) {
            self.fetchData()
        }else{
            RequestResponceHandler.shared.searchMovies(queryString: searchText) { (responceDic, error, str) in
                if error == nil{
                    self.movieObj = responceDic
                    self.movieGridView.reloadData()
                }
            }
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
        cell.movieTitleLbl.textColor = .black
        
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


