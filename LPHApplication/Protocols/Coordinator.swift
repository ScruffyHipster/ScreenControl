//
//  MainCoordinator.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
	var childCoordinators: [Coordinator] {get set}
	var navigationController: UINavigationController {get set}
	var networking: HTTP {get set}
	func iPhoneStart()
	func iPadStart()
}
