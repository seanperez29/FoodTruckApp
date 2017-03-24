//
//  GCDBlackBox.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/23/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
