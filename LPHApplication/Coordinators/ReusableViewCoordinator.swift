//
//  TimeSelectionCoordinator.swift
//  LPHApplication
//
//  Created by Tom Murray on 08/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class ReusableViewCoordinator: Coordinator {
	
	weak var parentCoordinator: MainCoordinator? 
	
	var childCoordinators = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var networking: HTTP
	
	var viewUseState: ReusableCollectionViewState?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.networking = HTTP()
	}
	
	func start() {
		let vc = ReusableCollectionViewController.instantiate()
		vc.coordinator = self
		vc.viewUseState = viewUseState
		vc.navigationItem.title = viewUseState == ReusableCollectionViewState.Timer ? "Time Selection" : "Deal selection"
		navigationController.pushViewController(vc, animated: true)

	}
	
	
}
