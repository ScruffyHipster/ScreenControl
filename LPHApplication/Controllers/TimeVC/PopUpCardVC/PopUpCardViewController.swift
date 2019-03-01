//
//  PopUpCardViewController.swift
//  LPHApplication
//
//  Created by Tom Murray on 01/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class PopUpCardViewController: UIViewController {
	
	
	//MARK:- Properties
	
	//MARK:- Outlets
	
	@IBOutlet weak var handleArea: UIView!
	@IBOutlet weak var handleView: UIView!
	@IBOutlet weak var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpView()
        // Do any additional setup after loading the view.
    }
	
	func setUpView() {
		self.handleView.layer.cornerRadius = 2
		self.handleArea.layer.cornerRadius =  20
		self.handleView.clipsToBounds = true
		self.handleArea.clipsToBounds = true
		//Add shadow
		self.view.layer.shadowColor = UIColor.black.cgColor
		self.view.layer.shadowOpacity = 0.4
		self.view.layer.shadowOffset = CGSize(width: 0, height: -2)
		self.view.layer.masksToBounds = false
		self.view.backgroundColor = UIColor.clear
	}
}

extension PopUpCardViewController: Storyboarded {
	
}
