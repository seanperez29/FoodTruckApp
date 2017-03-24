//
//  FoodTruckCell.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/23/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class FoodTruckCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var avgCostLabel: UILabel!

    func configureCell(_ foodTruck: FoodTruck) {
        nameLabel.text = foodTruck.name
        foodTypeLabel.text = foodTruck.foodType
        avgCostLabel.text = "$\(foodTruck.avgCost)"
    }

}
