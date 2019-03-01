//
//  Helpers.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

//DATA
let homeScreenDataSource: [Features] = [
	Features(name: "Timer", infoText: "This is where you can set the time for a show", image: "time"),
	Features(name: "Emergency", infoText: "Emergency messaging can be displayed on all or seperate zones", image: "alarm"),
	Features(name: "Deals", infoText: "Set deals and specific playlists in real time from here", image: "speech-bubbles")
]


extension UIView {
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		self.layer.mask = mask
	}
}


