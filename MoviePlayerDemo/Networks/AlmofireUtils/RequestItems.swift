//
//  RequestItems.swift
//  MoviePlayer
//
//  Created by Malti Maurya on 09/12/20.
//  Copyright © 2020 Malti Maurya. All rights reserved.
//

import Alamofire


// MARK: - Enums

enum NetworkEnvironment {
    case dev
    case production
    case stage
}

enum RequestItemsType {
    
    // MARK: Events
    case getMovies
    case fail
    
    
}

// MARK: - Extensions
// MARK: - EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch Apimanager.networkEnviroment {
        case .dev: return "https://api.themoviedb.org/3/movie/"
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .stage: return "https://api.themoviedb.org/3/movie/"
        }
    }
    
    var version: String {
        return "/3"
    }

    var path: String {
        switch self {
        case .getMovies :
            return "now_playing?api_key=" + Constants.appKey! + "&language=en-US&page=1"
        case .fail :
            return "fail"
        }
    }
    
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovies :
            return .get
        default:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            
        default: return ["Accept": "application/json"]
      
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}

