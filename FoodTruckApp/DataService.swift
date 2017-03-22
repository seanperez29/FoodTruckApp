//
//  DataService.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/21/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func trucksLoaded()
    func reviewsLoaded()
}

class DataService {
    weak var delegate: DataServiceDelegate?
    var foodTrucks = [FoodTruck]()
    var reviews = [Review]()
    
    //GET all food trucks
    func getAllFoodTrucks() {
        let session = URLSession.shared
        guard let url = URL(string: Constants.URLs.GET_ALL_FOODTRUCKS_URL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            guard (error == nil) else {
                print(error!.localizedDescription)
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Returned a status code other than 2xx!")
                return
            }
            guard let data = data else {
                print("Unable to obtain data")
                return
            }
            self.foodTrucks = FoodTruck.parseFoodTruckJSONData(data: data)
            self.delegate?.trucksLoaded()
            
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //GET all reviews for a specific food truck
    func getAllReviews(for truck: FoodTruck) {
        let session = URLSession.shared
        guard let url = URL(string: "\(Constants.URLs.GET_ALL_REVIEWS_URL)/\(truck.id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            guard (error == nil) else {
                print(error!.localizedDescription)
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Returned a status code other than 2xx!")
                return
            }
            guard let data = data else {
                print("Unable to obtain data")
                return
            }
            self.reviews = Review.parseReviewJSONData(data: data)
            self.delegate?.reviewsLoaded()
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    static let sharedInstance = DataService()
}
