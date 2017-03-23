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
    }
    
}
