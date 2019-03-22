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
	var coordinator: ReusableViewCoordinator?
	
	var interrupt: Interrupt?
	var playerGroup = PlayerGroupName.TheatreOne
	
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
		self.handleView.backgroundColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1.0)
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
			let tv = (view as? TimeSelectionView)!
			tv.cancelButton.addTarget(self, action: #selector(doSomething(_:)), for: .touchUpInside)
			contentView.addSubview(view)
			tv.timeSlider.addTarget(self, action: #selector(changeTimeLabel), for: .valueChanged)
			tv.segementedTheatreSelection.addTarget(self, action: #selector(changeTheatreSelection), for: .valueChanged)
			tv.sendRequest.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
			break
		case .Deals:
			let view = dealsView.load()
			contentView.addSubview(view)
			break
		case .Home:
			let alert = createAlert(title: "Oops", message: "Something has gone wrong here. Please close and try restarting the app. If issue persists please contact the developer", actionTitle: "OK")
			present(alert, animated: true)
			break
		}
		
	}
	
	@objc func sendRequest() {
		guard let interrupt = interrupt else {
			let alert = createAlert(title: "Cannot make request", message: "Please select an interrupt", actionTitle: "OK")
			present(alert, animated: true)
			return
		}
		coordinator?.makeNetworkRequest(group: playerGroup, interrupt: interrupt)
	}
	
	//MARK:- TimeSelectionView Selectors
	@objc func changeTheatreSelection() {
		switch timeView.segementedTheatreSelection.selectedSegmentIndex {
		case 0:
			timeView.theatreSelectionLabel.text = "Theatre 1"
			playerGroup = PlayerGroupName.TheatreOne
		case 1:
			timeView.theatreSelectionLabel.text = "Theatre 2"
			playerGroup = PlayerGroupName.TheatreTwo
		case 2:
			timeView.theatreSelectionLabel.text = "Theatre 3"
			playerGroup = PlayerGroupName.TheatreThree
		default:
			break
		}
	}
	
	@objc func doSomething(_ sender: Any) {
		print("move")
	}
	
	@objc func changeTimeLabel() {
		timeView.timeSlider.value = roundf(timeView.timeSlider.value)
		switch(timeView.timeSlider.value) {
		case 0:
			timeView.timeSelectionLabel.text = ""
			interrupt = nil
		case 1:
			timeView.timeSelectionLabel.text = "1 Min"
			interrupt = Interrupt.oneMinuteSign
		case 2:
			timeView.timeSelectionLabel.text = "5 Min"
			interrupt = Interrupt.fiveMinuteSign
		case 3:
			timeView.timeSelectionLabel.text = "10 Min"
			interrupt = Interrupt.tenMinuteSign
		default:
			break
		}
	}
	
	//MARK:- DealSelectionView Selectors
	
	
}

extension PopUpCardViewController: Storyboarded {
	
}
