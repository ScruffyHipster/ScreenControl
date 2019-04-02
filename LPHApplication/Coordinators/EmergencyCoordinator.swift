//
//  EmergencyCoordinator.swift
//  LPHApplication
//
//  Created by Tom Murray on 02/04/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class EmergencyCoordinator: Coordinator {
	
	var childCoordinators = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var networking: HTTP
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.networking = HTTP()
	}
	
}
