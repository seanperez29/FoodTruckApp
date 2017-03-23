//
//  MainVC.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/21/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.sharedInstance.getAllFoodTrucks()
        DataService.sharedInstance.delegate = self
    }


}

extension MainVC: DataServiceDelegate {
    func trucksLoaded() {
        print(DataService.sharedInstance.foodTrucks)
    }
    func reviewsLoaded() {
        
    }
}

