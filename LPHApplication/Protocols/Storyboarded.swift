//
//  Storyboarded.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit


protocol Storyboarded {
	static func instantiate() -> Self
	static func instantiateIpad() -> Self
}

extension Storyboarded where Self: UIViewController {
	
	static func instantiate() -> Self {
		//Get name of vc
		let fullName = NSStringFromClass(self)
		//returns the component after the . notation
		let className = fullName.components(separatedBy: ".")[1]
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		//Instatiate the view on the storyboard
		return storyboard.instantiateViewController(withIdentifier: className) as! Self
	}
	
	static func instantiateIpad() -> Self {
		let fullName = NSStringFromClass(self)
		let className = fullName.components(separatedBy: ".")[1]
		let storyboard = UIStoryboard(name: "iPadStoryboard", bundle: Bundle.main)
		return storyboard.instantiateViewController(withIdentifier: className) as! Self
	}
}
