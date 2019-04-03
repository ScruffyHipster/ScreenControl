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
	
	var networkStatusCode: Int?
	
	var deviceType: DeviceTypeModel?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.networking = HTTP()
	}
	
	lazy var reusableCollectionView: ReusableCollectionViewController = {
		let vc = ReusableCollectionViewController()
		return vc
	}()
	
	//MARK:- Function Errors
	func showSelectionError() {
		print("Theres been an error")
	}
	
	func makeNetworkRequest(group: PlayerGroupName, interrupt: Interrupt) {
		let request = networking.createRequest(for: group, with: interrupt)
		networking.sendRequest(url: request) { (success, statusCode) in
			if success && interrupt != Interrupt.cancel {
				print("success")
				self.networkSuccess(with: group, interrupt: interrupt)
			} else if success == false {
				self.networkStatusCode = statusCode
				self.reusableCollectionView.showError(statusCode: statusCode)
			} else if interrupt == Interrupt.cancel {
				print("Cancelled")
			}
		}
	}
	
	func networkSuccess(with group: PlayerGroupName, interrupt: Interrupt) {
		reusableCollectionView.dismissPopUpView()
		reusableCollectionView.addToCollectionView(group: group, interrupt: interrupt)
	}
	
	func start() {
		reusableCollectionView = ReusableCollectionViewController.instantiate()
		reusableCollectionView.coordinator = self
		reusableCollectionView.viewUseState = viewUseState
		reusableCollectionView.collectionViewDataSource.cellToUse = viewUseState
		reusableCollectionView.deviceType = deviceType
		setUpDevice(deviceType!)
		navigationController.pushViewController(reusableCollectionView, animated: true)
	}
	
	func setUpDevice(_ device: DeviceTypeModel) {
		guard let viewUseState = viewUseState else {return}
		switch device {
		case .iPad:
			switch viewUseState {
			case .Timer:
				reusableCollectionView.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
				reusableCollectionView.navigationItem.title = "Time Selection"
			case .Deals:
				reusableCollectionView.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
				reusableCollectionView.navigationItem.title = "Deal selection"
			case .Home:
				break
			}
		case .iPhone:
			reusableCollectionView.navigationItem.title = viewUseState == ReusableCollectionViewState.Timer ? "Time Selection" : "Deal Selection"
		}
	}
	
}
