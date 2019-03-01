//
//  TimeScreenViewController.swift
//  LPHApplication
//
//  Created by Tom Murray on 28/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class TimeScreenViewController: UIViewController {
	
	//MARK:- Outlets
	@IBOutlet weak var collectionView: UICollectionView!
	
	//MARK:- Properties
	weak var coordinator: MainCoordinator?
	lazy var collectionViewDataSource: CollectionViewDataSource = {
		let ds = CollectionViewDataSource()
		return ds
	}()
	//Popupview
	var popUpcardView: PopUpCardViewController?
	var popUpCardHandleArea: CGFloat = 65
	var popUpState: PopUpCardViewState = .collapsed
	var popUpViewVisible = false
	var nextCardState: PopUpCardViewState {
		return popUpViewVisible ? .extended : .collapsed
	}
	var popUpCardHeight: CGFloat {
		return self.view.bounds.height - 160
	}
	var animationProperties = [UIViewPropertyAnimator]()
	var animationProgressWasInterrupted: CGFloat = 0
	
	
	//MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
		setUpCollectionView()
		loadNibs()
		setUpPopUpView()
    }
	
	func setUpCollectionView() {
		collectionView.dataSource = collectionViewDataSource
		collectionView.delegate = self
		collectionView.isScrollEnabled = false
	}
	
	func loadNibs() {
		let nib = UINib(nibName: CollectionViewCellIdentifiers.TimeScreenCell.identifier, bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.TimeScreenCell.identifier)
		popUpcardView = PopUpCardViewController(nibName: ViewControllerNibIdentifiers.popUpCardViewController.identifier, bundle: nil)
	}
	
	func setUpPopUpView() {
		guard let popUpView = popUpcardView else {return}
		self.addChild(popUpView)
		self.view.addSubview(popUpView.view)
		//Set up card View height
		popUpView.view.frame = CGRect(x: 0.0, y: self.view.bounds.height - popUpCardHandleArea, width: self.view.bounds.width, height: self.view.bounds.height - popUpCardHandleArea)
	}

}

extension TimeScreenViewController: UICollectionViewDelegate {
	
}

extension TimeScreenViewController: Storyboarded {
	
}
