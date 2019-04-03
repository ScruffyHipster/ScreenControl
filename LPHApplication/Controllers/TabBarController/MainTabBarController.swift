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
	
	var reusableCoordinator: ReusableViewCoordinator?
	var reusableCoordinator2: ReusableViewCoordinator?
	var emergencyCoordinator: EmergencyCoordinator?
	
	func loadViewControllers() {
		guard let reusableCoordinator = reusableCoordinator, let emergencyCoordinator = emergencyCoordinator, let reusableCoordinator2 = reusableCoordinator2 else {return}
		reusableCoordinator.viewUseState = ReusableCollectionViewState.Timer
		reusableCoordinator.viewUseState = ReusableCollectionViewState.Timer
		reusableCoordinator2.viewUseState = ReusableCollectionViewState.Deals
		reusableCoordinator.start()
		reusableCoordinator2.start()
		emergencyCoordinator.start()
		viewControllers = [reusableCoordinator.navigationController, reusableCoordinator2.navigationController, emergencyCoordinator.navigationController]
	}
}
