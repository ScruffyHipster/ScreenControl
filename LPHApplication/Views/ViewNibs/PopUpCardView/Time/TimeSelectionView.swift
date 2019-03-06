//
//  TimeSelectionView.swift
//  LPHApplication
//
//  Created by Tom Murray on 06/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class TimeSelectionView: UIView, NIBLoader {
	
	
	//MARK:- Outlet
	@IBOutlet weak var timeLabel: UILabel!
	
	
	
	//Protocol Methods
	func load() -> UIView {
		let nib = UINib(nibName: UIViewNibIdentifiers.timeViewNib.identifier, bundle: nil)
		return nib.instantiate(withOwner: self, options: nil).first as! UIView
	}
}

