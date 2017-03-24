//
//  MainVC.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/21/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIImageView!
    var dataService = DataService.sharedInstance
    var authService = AuthService.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.getAllFoodTrucks()
        dataService.delegate = self
    }


}

extension MainVC: DataServiceDelegate {
    func trucksLoaded() {
        performUIUpdatesOnMain {
            self.tableView.reloadData()
        }
    }
    
    func reviewsLoaded() {
        
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTruckCell", for: indexPath) as! FoodTruckCell
        let foodTruck = dataService.foodTrucks[indexPath.row]
        cell.configureCell(foodTruck)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.foodTrucks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

