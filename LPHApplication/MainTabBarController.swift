//
//  MainiPadTabBarController.swift
//  LPHApplication
//
//  Created by Tom Murray on 02/04/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
	
	var mainCoordinator: MainCoordinator?
	var reusableCoordinator: ReusableViewCoordinator?
	var emergencyCoordinator: EmergencyCoordinator?
	
	func loadViewControllers() {
		guard let mainCoor = mainCoordinator else {return}
		mainCoor.start()
		viewControllers = [mainCoor.navigationController]
	}
}
