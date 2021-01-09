//
//  Constants.swift
//  MoviePlayer
//
//  Created by Malti Maurya on 15/12/20.
//  Copyright © 2020 Malti Maurya. All rights reserved.
//

import Foundation

class Constants
{
    static let defaultAlertTitle = "warning"
    static let errorAlertTitle = "error"
    static let genericErrorMessage = "Something went wrong, please try again."
    static let APP_VERSION = "1.0"
    static let appKey = Bundle.main.infoDictionary!["APPKey"] as? String
    static let imageURL = "https://image.tmdb.org/t/p/w500"

}
