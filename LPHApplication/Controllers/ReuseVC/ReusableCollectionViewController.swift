//
//  TimeScreenViewController.swift
//  LPHApplication
//
//  Created by Tom Murray on 28/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class ReusableCollectionViewController: UIViewController {
	
	//MARK:- Outlets
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var instructionLabel: UILabel! {
		didSet {
			if viewUseState == ReusableCollectionViewState.Deals {
				instructionLabel.text = "Add deals"
			} else {
				instructionLabel.text = "Add time"
			}
		}
	}
	
	//MARK:- Properties
	weak var coordinator: ReusableViewCoordinator?
	lazy var collectionViewDataSource: CollectionViewDataSource = {
		let ds = CollectionViewDataSource()
		return ds
	}()
	//State of use
	var viewUseState: ReusableCollectionViewState?
	//Popupview
	var popUpcardView: PopUpCardViewController?
	var popUpCardHandleArea: CGFloat = 65
	var popUpViewVisible = false
	var nextCardState: PopUpCardViewState {
		return popUpViewVisible ? .extended : .collapsed
	}
	var popUpCardHeight: CGFloat {
		return self.view.bounds.height - 160
	}
	var compressedHeight: CGFloat = 60.0
	var animationProperties = [UIViewPropertyAnimator]()
	var animationProgressWasInterrupted: CGFloat = 0
	var timeSelectionArray = [TimeSelection]()
	
	//MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
		setUpCollectionView()
		loadNibs()
		setUpPopUpView()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationItem.rightBarButtonItem = editButtonItem
	}

	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		collectionView.allowsSelection = editing
		navigationItem.leftBarButtonItem = editing ? UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteItems)) : nil
	}
	
	@objc func deleteItems() {
	
	}
	
	func showError(statusCode: Int) {
		let alert = createAlert(title: "Network Error", message: "Sorry, theres been an error when making the request. Error code: \(statusCode)", actionTitle: "OK")
		present(alert, animated: true)
	}
	
	func addToCollectionView(group: PlayerGroupName, interrupt: Interrupt) {
		guard let viewUseState = viewUseState else {return}
		switch viewUseState {
		case ReusableCollectionViewState.Timer:
			let time = TimeSelection(theatrenName: group.playGroupString, timeToGo: interrupt.interruptString)
			timeSelectionArray.append(time)
			collectionViewDataSource.populateData(with: timeSelectionArray)
			instructionLabel.alpha = 0.0
		case ReusableCollectionViewState.Deals:
			break
		case ReusableCollectionViewState.Home:
			break
		}
		collectionView.reloadData()
	}
	
	//MARK:- CollectionView setup methods
	func setUpCollectionView() {
		collectionView.dataSource = collectionViewDataSource
		collectionView.delegate = self
		setUpCollectionViewLayout()
		collectionView.isScrollEnabled = false
	}
	
	func loadNibs() {
		popUpcardView = PopUpCardViewController(nibName: ViewControllerNibIdentifiers.popUpCardViewController.identifier, bundle: nil)
		guard let viewUse = viewUseState, let coord = coordinator else {return}
		//Sets popup view to correct use state
		popUpcardView?.viewUseState = viewUse
		//Sets the coordinator
		popUpcardView?.coordinator = coord
		//Sets collection view up with the correct use NIBS
		switch viewUse {
		case .Deals:
			let nib = UINib(nibName: CollectionViewCellIdentifiers.DealsScreenCell.identifier, bundle: nil)
			collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.DealsScreenCell.identifier)
			break
		case .Timer:
			let nib = UINib(nibName: CollectionViewCellIdentifiers.TimeScreenCell.identifier, bundle: nil)
			collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.TimeScreenCell.identifier)
			break
		case .Home:
			break
		}
	}
	
	func setUpCollectionViewLayout() {
		let width = view.bounds.width - 20
		let height = view.bounds.height / 4
		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: height)
		layout.sectionInset = UIEdgeInsets(top: 20, left: 80, bottom: 20, right: 80)
		layout.minimumLineSpacing = 12.0
		layout.minimumInteritemSpacing = 10.0
	}
	
	
	//MARK:- Pop up view
	func setUpPopUpView() {
		guard let popUpView = popUpcardView else {return}
		self.addChild(popUpView)
		self.view.addSubview(popUpView.view)
		//Set up card View height
		popUpView.view.frame = CGRect(x: 0.0, y: self.view.bounds.height - popUpCardHandleArea, width: self.view.bounds.width, height: self.view.bounds.height - popUpCardHandleArea)
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleViewWasPanned(recognizer:)))
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewWasTapped(recognizer:)))
		popUpView.handleArea.addGestureRecognizer(panGesture)
		popUpView.handleArea.addGestureRecognizer(tapGesture)
	}
	
	func dismissPopUpView() {
		guard popUpcardView != nil else {return}
		animateTransition(fromState: nextCardState, withDuration: 0.7)
	}
	
	@objc func handleViewWasPanned(recognizer: UIPanGestureRecognizer) {
		let translation = recognizer.translation(in: popUpcardView?.handleArea)
		switch recognizer.state {
		case .ended:
			continueInteractiveTransition()
			break
		case .changed:
			if recognizer.velocity(in: popUpcardView?.handleArea).y / self.view.bounds.height > 0.5 {
				var fractionComplete = translation.y / popUpCardHeight
				fractionComplete = popUpViewVisible ? fractionComplete : -fractionComplete
				updateInteractiveTransition(fractionCompleted: fractionComplete)
			}
			break
		case .began:
			startInteractiveTransition(state: nextCardState, duration: 0.8)
			break
		default:
			break
		}
	}
	
	@objc func handleViewWasTapped(recognizer: UITapGestureRecognizer) {
		if recognizer.state == .ended {
			animateTransition(fromState: nextCardState, withDuration: 0.7)
		}
	}
	
	func startInteractiveTransition(state: PopUpCardViewState, duration: Double) {
		if animationProperties.isEmpty {
			animateTransition(fromState: state, withDuration: duration)
		}
		for animator in animationProperties {
			animator.pauseAnimation()
			animationProgressWasInterrupted = animator.fractionComplete
		}
	}
	
	func animateTransition(fromState state: PopUpCardViewState, withDuration duration: Double) {
		guard let popUpView = popUpcardView else {return}
		if animationProperties.isEmpty {
			let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
				switch state {
				case .collapsed:
					popUpView.view.frame.origin.y = self.view.frame.height - self.popUpCardHeight
				case .extended:
					popUpView.view.frame.origin.y = self.view.frame.height - self.compressedHeight
				}
			}
			frameAnimator.addCompletion { (_) in
				self.popUpViewVisible = !self.popUpViewVisible
				self.animationProperties.removeAll()
			}
			frameAnimator.startAnimation()
			animationProperties.append(frameAnimator)
		}
	}
	
	func updateInteractiveTransition(fractionCompleted: CGFloat) {
		for animator in animationProperties {
			animator.fractionComplete = fractionCompleted + animationProgressWasInterrupted
		}
	}
	
	func continueInteractiveTransition() {
		for animator in animationProperties {
			animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
		}
	}

}

extension ReusableCollectionViewController: UICollectionViewDelegate {
	
}

extension ReusableCollectionViewController: Storyboarded {
	
}
