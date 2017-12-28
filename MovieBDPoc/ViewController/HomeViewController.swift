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

    @IBOutlet weak var movieGridView: UICollectionView!
    
    var movieObj = [MovieEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchData()
        self.initalizeUiComponents()
    }
    
    
    func initalizeUiComponents() {
        movieGridView.delegate = self
        movieGridView.dataSource = self
        
        movieGridView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        view.addSubview(movieGridView)
        
        
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

class HomeVCCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    
}

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
        print(indexPath.row)
    }
    
}
