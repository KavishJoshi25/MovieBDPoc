//
//  DetailViewController.swift
//  MovieBDPoc
//
//  Created by Kavish joshi on 28/12/17.
//  Copyright © 2017 Kavish joshi. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var movieDetailsObj:MovieEntity? = nil
    var detailTableView:UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .black
        self.initializeUIComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //Mark:- Initalize UI Components
    func initializeUIComponents() {
        
        //Uitable view
        detailTableView.backgroundColor = UIColor.clear
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorStyle = .none
        detailTableView.allowsSelection = false
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        detailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TCell")
        view.addSubview(detailTableView)
        
        NSLayoutConstraint.activate([detailTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),detailTableView.leftAnchor.constraint(equalTo: view.leftAnchor),detailTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0), detailTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)])
        
    }
}

extension DetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    //Tableview DelegateMethods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCell", for: indexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    //MARK: table Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView:UIView = UIView()
        let movieImageView = UIImageView()
        let url = NSURL(string:AppBaseUrl.imageUrl + (movieDetailsObj?.poster_path)!)
        movieImageView.af_setImage(withURL:  url! as URL)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = UIColor.green
        movieImageView.backgroundColor = UIColor.clear
        
        self.view.addSubview(headerView)
        headerView.addSubview(movieImageView)
        
        NSLayoutConstraint.activate([headerView.topAnchor.constraint(equalTo: tableView.topAnchor,constant:0), headerView.leftAnchor.constraint(equalTo: tableView.leftAnchor), headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor),headerView.heightAnchor.constraint(equalToConstant: 250)])
        
        
        NSLayoutConstraint.activate([movieImageView.topAnchor.constraint(equalTo: headerView.topAnchor,constant:0),
                                     movieImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                                     movieImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1.0),
                                     movieImageView.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1.0)])
        
        let movieTitle = UILabel()
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.text = "Title: " + (movieDetailsObj?.title)!
        movieTitle.textAlignment = .left
        movieTitle.textColor = UIColor.white
        headerView.addSubview(movieTitle)
        NSLayoutConstraint.activate([movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant:15),
                                     movieTitle.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     movieTitle.widthAnchor.constraint(equalTo: headerView.widthAnchor),
                                     movieTitle.heightAnchor.constraint(equalToConstant: 25)])
        
        
        let vote_average = UILabel()
        vote_average.translatesAutoresizingMaskIntoConstraints = false
        vote_average.text = "vote_average: " + "\(movieDetailsObj?.vote_average ?? 0)"
        vote_average.textAlignment = .left
        vote_average.textColor = UIColor.white
        headerView.addSubview(vote_average)
        NSLayoutConstraint.activate([vote_average.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant:15),
                                     vote_average.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     vote_average.widthAnchor.constraint(equalTo: headerView.widthAnchor),
                                     vote_average.heightAnchor.constraint(equalToConstant: 25)])
        
        
        let releaseDate = UILabel()
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.text = "Release Date: " +  (movieDetailsObj?.release_date)!
        releaseDate.textAlignment = .left
        releaseDate.textColor = UIColor.white
        headerView.addSubview(releaseDate)
        NSLayoutConstraint.activate([releaseDate.topAnchor.constraint(equalTo: vote_average.bottomAnchor,constant:15),
                                     releaseDate.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     releaseDate.widthAnchor.constraint(equalTo: headerView.widthAnchor),
                                     releaseDate.heightAnchor.constraint(equalToConstant: 25)])
        
        
        let movieOverView = UILabel()
        movieOverView.translatesAutoresizingMaskIntoConstraints = false
        movieOverView.text = "OverView: " + (movieDetailsObj?.overview)!
        movieOverView.textAlignment = .left
        movieOverView.textColor = UIColor.white
        
        movieOverView.numberOfLines = 8
        headerView.addSubview(movieOverView)
        NSLayoutConstraint.activate([movieOverView.topAnchor.constraint(equalTo: releaseDate.bottomAnchor,constant:15),
                                     movieOverView.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant:0),
                                     movieOverView.widthAnchor.constraint(equalTo: headerView.widthAnchor,constant:0),
                                     movieOverView.heightAnchor.constraint(equalToConstant: 120)])

        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 500
    }
    
    
}




