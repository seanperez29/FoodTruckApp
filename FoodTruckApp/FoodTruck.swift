//
//  FoodTruck.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/21/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class FoodTruck: NSObject, MKAnnotation {
    var id: String = ""
    var name: String = ""
    var foodType: String = ""
    var avgCost: Double = 0.0
    var geometryType: String = "Point"
    var lat: Double = 0.0
    var long: Double = 0.0
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return foodType
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    static func parseFoodTruckJSONData(data: Data) -> [FoodTruck] {
        var foodtrucks = [FoodTruck]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let trucks = jsonResult as? [[String:AnyObject]] {
                for truck in trucks {
                    let newTruck = FoodTruck()
                    newTruck.id = truck["_id"] as! String
                    newTruck.name = truck["name"] as! String
                    newTruck.foodType = truck["foodtype"] as! String
                    newTruck.avgCost = truck["avgcost"] as! Double
                    let geometry = truck["geometry"] as! [String:AnyObject]
                    newTruck.geometryType = geometry["type"] as! String
                    let coordinates = geometry["coordinates"] as! [String:AnyObject]
                    newTruck.lat = coordinates["lat"] as! Double
                    newTruck.long = coordinates["long"] as! Double
                    foodtrucks.append(newTruck)
                }
            }
        } catch {
            print(error)
        }
        
        return foodtrucks
    }
}
