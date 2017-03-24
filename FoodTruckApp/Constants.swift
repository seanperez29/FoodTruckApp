//
//  Constants.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/21/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

class Constants {
    
    struct Callbacks {
        typealias callback = (_ success: Bool) -> ()
    }
    
    struct URLs {
        static let BASE_API_URL = "http://localhost:3005/api/v1"
        static let GET_ALL_FOODTRUCKS_URL = "\(BASE_API_URL)/foodtruck"
        static let GET_ALL_REVIEWS_URL = "\(BASE_API_URL)/reviews"
        static let POST_ADD_NEW_TRUCK = "\(BASE_API_URL)/foodtruck/add"
        static let POST_ADD_NEW_REVIEW = "\(BASE_API_URL)/foodtruck/review/add"
        static let POST_REGISTER_ACCOUNT = "\(BASE_API_URL)/account/register"
        static let POST_LOGIN_ACCOUNT = "\(BASE_API_URL)/account/login"
    }
    
    struct Keys {
        static let DEFAULTS_REGISTERED = "isRegistered"
        static let DEFAULTS_AUTHENTICATED = "isAuthenticated"
        static let DEFAULTS_EMAIL = "email"
        static let DEFAULTS_TOKEN = "authToken"
    }
    
}
