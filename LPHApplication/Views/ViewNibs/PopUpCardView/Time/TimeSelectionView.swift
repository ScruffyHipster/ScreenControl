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
	@IBOutlet weak var timeSlider: UISlider!
	@IBOutlet weak var segementedTheatreSelection: UISegmentedControl! {
		didSet {
			segementedTheatreSelection.tintColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1)
		}
	}
	@IBOutlet weak var theatreSelectionLabel: UILabel! {
		didSet {
			theatreSelectionLabel.text = "Theatre 1"
		}
	}
	@IBOutlet weak var timeSelectionLabel: UILabel!
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var sendRequest: UIButton!
	
	//Protocol Methods
	func load() -> UIView {
		let nib = UINib(nibName: UIViewNibIdentifiers.timeViewNib.identifier, bundle: nil)
		return nib.instantiate(withOwner: self, options: nil).first as! UIView
	}
}

