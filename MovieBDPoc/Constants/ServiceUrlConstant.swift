//
//  ServiceUrlConstant.swift
//  MovieBDPoc
//
//  Created by Kavish joshi on 28/12/17.
//  Copyright © 2017 Kavish joshi. All rights reserved.
//

import Foundation

struct AppBaseUrl {
    
    private static let baseUrl = "https://api.themoviedb.org/3/"
    private static let apiKey = "api_key=fc34479a99499135f6168013344e9014"
    
    //popularMovie Call
    static var popularMovie : String {
        return baseUrl + "movie/popular?" + apiKey
    }
    
    //Search Call
    static var searchMovie : String {
        return baseUrl + "search/movie?" + apiKey + "&language=en-US&query="
    }
    
    //Search query
    static var searchQuery : String {
        return  "&page=1&include_adult=false"
    }
    
    
    //imageUrl Call
    static var imageUrl : String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
    
    
}
