//
//  MainCoordinator.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator {
	
	static var dataArray: [AnyObject]?
	
	var childCoordinators = [Coordinator]()
	var networking: HTTP
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.networking = HTTP()
	}
	
	func start() {
		let vc = HomeViewController.instantiate()
		vc.mainCoordinator = self
		vc.loadView()
		vc.setUpCollectionView()
		navigationController.delegate = self
		navigationController.navigationBar.prefersLargeTitles = true
		navigationController.pushViewController(vc, animated: false)
	}
	
	func timeSelection() {
		let child = ReusableViewCoordinator(navigationController: navigationController)
		childCoordinators.append(child)
		child.parentCoordinator = self
		child.viewUseState = ReusableCollectionViewState.Timer
		child.start()
}
	
	func dealsController() {
		let child = ReusableViewCoordinator(navigationController: navigationController)
		child.parentCoordinator = self
		childCoordinators.append(child)
		child.viewUseState = ReusableCollectionViewState.Deals
		child.start()
	}

	func emergencyController() {
		let vc = EmergencyViewController.instantiate()
		vc.coordinator = self
		navigationController.pushViewController(vc, animated: true)
	}
	
	func childDidFinish(_ child: Coordinator?) {
		for (index, coordinator) in childCoordinators.enumerated() {
			if coordinator === child {
				childCoordinators.remove(at: index)
				break
			}
		}
	}
	
	//MARK:- Networking
	func httpRequest(group: PlayerGroupName, interrupt: Interrupt) {
		print("make request for \(group) with interupt \(interrupt)")
	}
	
}

extension MainCoordinator: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
		//Read  the vc we're moving from
		guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
		//check whether our array already contains that vc
		if navigationController.viewControllers.contains(fromVC) {
			return
		}
		//Were still here. it means we're popping the view controller so we can check if its the reusable view
		if let reuseViewController = fromVC as? ReusableCollectionViewController {
		childDidFinish(reuseViewController.coordinator)
		}
	}
}
