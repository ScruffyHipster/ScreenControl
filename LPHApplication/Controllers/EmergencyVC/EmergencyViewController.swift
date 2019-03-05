//
//  EmergencyViewController.swift
//  LPHApplication
//
//  Created by Tom Murray on 05/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class EmergencyViewController: UIViewController {
	
	//MARK:- Outlets
	@IBOutlet weak var emergencyInfoLabel: UILabel!
	@IBOutlet weak var emergencyInitiateButton: UIButton! {
		didSet {
			emergencyInitiateButton.roundCorners(corners: [.allCorners], radius: 8)
		}
	}
	@IBOutlet weak var sendButton: UIButton!

	
	//MARK:- Properties
	weak var coordinator: MainCoordinator?
	
	
	//MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

//MARK:- Storyboarded
extension EmergencyViewController: Storyboarded {
	
}
