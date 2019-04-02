//
//  EmergencyCoordinator.swift
//  LPHApplication
//
//  Created by Tom Murray on 02/04/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

//For iPad use currently. Will change this out to iPhone as well for convinience and consistancy.

import Foundation
import UIKit

class EmergencyCoordinator: Coordinator {
	
	var childCoordinators = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var networking: HTTP
	
	var deviceType: DeviceTypeModel?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.networking = HTTP()
	}
	
	//MARK:- Properties
	
	lazy var emergencyViewController: EmergencyViewController = {
		var evc = EmergencyViewController()
		return evc
	}()
	
	func start() {
		emergencyViewController = EmergencyViewController.instantiateIpad()
		emergencyViewController.tempCoordinator = self
		emergencyViewController.deviceType = deviceType
		setUpDevice(deviceType!)
		navigationController.pushViewController(emergencyViewController, animated: false)
	}
	
	
	func setUpDevice(_ device: DeviceTypeModel) {
		switch device {
		case .iPad:
			emergencyViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
			emergencyViewController.navigationItem.title = "Emergency Screen"
		case .iPhone:
			//To be continued...
			break
		}
	}
}
