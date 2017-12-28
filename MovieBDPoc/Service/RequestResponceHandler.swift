//
//  RequestResponceHandler.swift
//  MovieBDPoc
//
//  Created by Kavish joshi on 28/12/17.
//  Copyright © 2017 Kavish joshi. All rights reserved.
//


import Foundation
import Alamofire

typealias ResponseWithDic = ([MovieEntity], NSError?,String?) -> Void
typealias searchResponseWithDic = (AnyObject, NSError?,String?) -> Void

class RequestResponceHandler: NSObject {
    
    // MARK: Shared Instance
    static let shared = RequestResponceHandler()
    
    var popularMovieRequestInstance : Request? = nil
    
    //MARK:getMostPopularMovies
    func getMostPopularMovies(onCompletion: @escaping ResponseWithDic)  {
        
        if (popularMovieRequestInstance != nil) {
            popularMovieRequestInstance?.cancel()
        }
        popularMovieRequestInstance = Alamofire.request(AppBaseUrl.popularMovie).responseJSON(completionHandler: { (responce) in
            self.popularMovieRequestInstance = nil
            
            if let json = responce.result.value {
                
                let movieObj:Dictionary = json as! Dictionary<String,Any>
                
                let resultArr = movieObj["results"] as! NSArray
                
                var movieArrayReturn:[MovieEntity] = [MovieEntity]()
                
                for item in resultArr{
                    
                    let movieEntityObj:MovieEntity = MovieEntity()
                    
                    let dicOne = item as! NSDictionary
                    
                    movieEntityObj.adult = dicOne["adult"]! as! Bool
                    movieEntityObj.vote_count = dicOne["vote_count"]! as! NSInteger
                    movieEntityObj.id = dicOne["id"] as! NSInteger
                    movieEntityObj.video = dicOne["video"] as! Bool
                    movieEntityObj.vote_average = Int(truncating: dicOne["vote_average"]  as! NSNumber)
                    movieEntityObj.title = dicOne["title"] as! String
                    movieEntityObj.popularity = Int(truncating: dicOne["popularity"] as! NSNumber)
                    movieEntityObj.poster_path = dicOne["poster_path"]  as! String
                    movieEntityObj.original_language = dicOne["original_language"]  as! String
                    movieEntityObj.original_title = dicOne["original_title"]  as! String
                    movieEntityObj.backdrop_path = dicOne["backdrop_path"]  as! String
                    movieEntityObj.overview = dicOne["overview"]  as! String
                    movieEntityObj.release_date = dicOne["release_date"]  as! String
                    
                    movieArrayReturn.append(movieEntityObj)
                }
                onCompletion(movieArrayReturn , nil, "")
            }else{
                onCompletion([], responce.error! as NSError, "")
            }
            
        })
    }
    
    //---------End of getMostPopularMovies
    
    //MARK:searchMovies
    func searchMovies(queryString:String,onCompletion: @escaping ResponseWithDic)  {
        
        if (popularMovieRequestInstance != nil) {
            popularMovieRequestInstance?.cancel()
        }
        
        popularMovieRequestInstance = Alamofire.request(AppBaseUrl.searchMovie + "\(queryString)" + AppBaseUrl.searchQuery ).responseJSON(completionHandler: { (responce) in
            self.popularMovieRequestInstance = nil
            
            if let json = responce.result.value {
                
                let movieObj:Dictionary = json as! Dictionary<String,Any>
                
//                let totalPages = movieObj["total_pages"] as! NSInteger
                
                let resultArr = movieObj["results"] as! NSArray
                
                var movieArrayReturn:[MovieEntity] = [MovieEntity]()
                
                for item in resultArr{
                    
                    let movieEntityObj:MovieEntity = MovieEntity()
                    
                    let dicOne = item as! NSDictionary
                    
                    movieEntityObj.vote_count = dicOne["vote_count"]! as! NSInteger
                    movieEntityObj.id = dicOne["id"] as! NSInteger
                    movieEntityObj.video = dicOne["video"] as! Bool
                    movieEntityObj.vote_average = Int(truncating: dicOne["vote_average"]  as! NSNumber)
                    movieEntityObj.title = dicOne["title"] as! String
                    movieEntityObj.popularity = Int(truncating: dicOne["popularity"] as! NSNumber)
                    movieEntityObj.poster_path = dicOne["poster_path"]  as? String ?? ""
                    movieEntityObj.original_language = dicOne["original_language"]  as! String
                    movieEntityObj.original_title = dicOne["original_title"]  as! String
                    
                    movieEntityObj.backdrop_path = dicOne["backdrop_path"]  as? String ?? ""
                    movieEntityObj.adult = dicOne["adult"]  as! Bool

                    movieEntityObj.overview = dicOne["overview"]  as! String
                    movieEntityObj.release_date = dicOne["release_date"]  as! String
                    
                    movieArrayReturn.append(movieEntityObj)
                }
                onCompletion(movieArrayReturn , nil, "")
            }else{
                onCompletion([], responce.error! as NSError, "")
            }
            
        })
    }
}
