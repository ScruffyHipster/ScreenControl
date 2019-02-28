//
//  MainCoordinator.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
	
	static var dataArray: [AnyObject]?
	
	var childCoordinators = [Coordinator]()
	
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let vc = HomeViewController.instantiate()
		vc.mainCoordinator = self
		vc.loadView()
		vc.setUpCollectionView()
		navigationController.navigationBar.prefersLargeTitles = true
		navigationController.pushViewController(vc, animated: false)
	}
	
	
}
