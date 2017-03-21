//
//  Review.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/21/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

struct Review {
    var id: String = ""
    var title: String = ""
    var text: String = ""
    
    static func parseReviewJSONData(data: Data) -> [Review] {
        var foodTruckReviews = [Review]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:AnyObject]]
            if let reviews = jsonResult {
                for review in reviews {
                    var newReview = Review()
                    newReview.id = review["_id"] as! String
                    newReview.title = review["title"] as! String
                    newReview.text = review["text"] as! String
                    foodTruckReviews.append(newReview)
                }
            }
        } catch {
            print(error)
        }
        return foodTruckReviews
    }
}
