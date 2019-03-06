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
	var viewUseState: ReusableCollectionViewState?
	lazy var timeView: TimeSelectionView = {
		let view = TimeSelectionView()
		return view
	}()
	lazy var dealsView: DealsSelectionView = {
		let view = DealsSelectionView()
		return view
	}()
	
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
		//Set state
		guard let viewState = viewUseState else {return}
		switch viewState {
		case .Timer:
			let view = timeView.load()
			contentView.addSubview(view)
			break
		case .Deals:
			let view = dealsView.load()
			contentView.addSubview(view)
			break
		}
		
	}
}

extension PopUpCardViewController: Storyboarded {
	
}
