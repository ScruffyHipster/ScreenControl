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
	lazy var emergencyViewController: EmergencyViewController = {
		var ev = EmergencyViewController()
		return ev
	}()
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.networking = HTTP()
	}
	
	func iPhoneStart() {
		let vc = HomeViewController.instantiate()
		vc.mainCoordinator = self
		vc.loadView()
		vc.setUpCollectionView()
		navigationController.delegate = self
		navigationController.navigationBar.prefersLargeTitles = true
		navigationController.pushViewController(vc, animated: false)
	}
	
	func iPadStart() {
		print("starting iPad coordinator")
	}
	
	func timeSelection() {
		let child = ReusableViewCoordinator(navigationController: navigationController)
		childCoordinators.append(child)
		child.parentCoordinator = self
		child.viewUseState = ReusableCollectionViewState.Timer
		child.iPhoneStart()
}
	
	func dealsController() {
		let child = ReusableViewCoordinator(navigationController: navigationController)
		child.parentCoordinator = self
		childCoordinators.append(child)
		child.viewUseState = ReusableCollectionViewState.Deals
		child.iPhoneStart()
	}

	func emergencyController() {
		emergencyViewController = EmergencyViewController.instantiate()
		emergencyViewController.coordinator = self
		navigationController.pushViewController(emergencyViewController, animated: true)
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
		let request = networking.createRequest(for: group, with: interrupt)
		networking.sendRequest(url: request) { (success, statusCode) in
			if success {
				print("success")
				self.emergencyViewController.emergencyInProgress()
			} else if !success {
				print("Failed with status code \(statusCode)")
			}
		}
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
