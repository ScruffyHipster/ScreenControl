//
//  DealsSelectionView.swift
//  LPHApplication
//
//  Created by Tom Murray on 06/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class DealsSelectionView: UIView, NIBLoader {
	
	//MARK:- Outlet
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var sendRequest: UIButton!
	@IBOutlet weak var playListOneButton: UIButton!
	@IBOutlet weak var playListTwoButton: UIButton!
	@IBOutlet weak var playlistThreeButton: UIButton!
	@IBOutlet weak var zoneOneButton: UIButton!
	@IBOutlet weak var zoneTwoButton: UIButton!
	@IBOutlet weak var zoneThreeButton: UIButton!
	@IBOutlet weak var zoneFourButton: UIButton!
	@IBOutlet weak var zoneFiveButton: UIButton!
	@IBOutlet weak var zoneSixButton: UIButton!
	@IBOutlet weak var zonesButtonsStackView: UIStackView!
	@IBOutlet weak var playlistButtonStackView: UIStackView!
	@IBOutlet weak var playlistTitleLabel: UILabel!
	@IBOutlet weak var zoneTitlesLabel: UILabel!
	@IBOutlet weak var playlistLabel: UILabel! {
		didSet {
			playlistLabel.text = ""
		}
	}
	@IBOutlet weak var zoneLabel: UILabel! {
		didSet {
			zoneLabel.text = ""
		}
	}

	
	//Protocol methods
	func load() -> UIView {
		let nib = UINib(nibName: UIViewNibIdentifiers.dealViewNib.identifier, bundle: nil)
		return nib.instantiate(withOwner: self, options: nil).first as! UIView
	}
	
}
