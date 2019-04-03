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
	var deviceType: DeviceTypeModel?
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
		//Set state
		guard let viewState = viewUseState else {return}
		guard let deviceType = deviceType else {return}
		switch viewState {
		case .Timer:
			let view = timeView.load()
			let tv = (view as? TimeSelectionView)!
			tv.cancelButton.addTarget(self, action: #selector(doSomething(_:)), for: .touchUpInside)
			contentView.addSubview(view)
			tv.timeSlider.addTarget(self, action: #selector(changeLabels), for: .valueChanged)
			tv.segementedTheatreSelection.addTarget(self, action: #selector(changeTheatreSelection), for: .valueChanged)
			tv.sendRequest.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
			break
		case .Deals:
			let view = dealsView.load()
			let dv = (view as? DealsSelectionView)!
			contentView.addSubview(view)
			dv.cancelButton.addTarget(self, action: #selector(doSomething(_:)), for: .touchUpInside)
			dv.sendRequest.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
			dv.playListOneButton.addTarget(self, action: #selector(changePlaylistSelection(_:)), for: .touchUpInside)
			dv.playListTwoButton.addTarget(self, action: #selector(changePlaylistSelection(_:)), for: .touchUpInside)
			dv.playlistThreeButton.addTarget(self, action: #selector(changePlaylistSelection(_:)), for: .touchUpInside)
			dv.zoneOneButton.addTarget(self, action: #selector(changeZoneLabel(_:)), for: .touchUpInside)
			dv.zoneTwoButton.addTarget(self, action: #selector(changeZoneLabel(_:)), for: .touchUpInside)
			dv.zoneThreeButton.addTarget(self, action: #selector(changeZoneLabel(_:)), for: .touchUpInside)
			dv.zoneFourButton.addTarget(self, action: #selector(changeZoneLabel(_:)), for: .touchUpInside)
			dv.zoneFiveButton.addTarget(self, action: #selector(changeZoneLabel(_:)), for: .touchUpInside)
			dv.zoneSixButton.addTarget(self, action: #selector(changeZoneLabel(_:)), for: .touchUpInside)
			dv.playListOneButton.tag = 101
			dv.playListTwoButton.tag = 102
			dv.playlistThreeButton.tag = 103
			dv.zoneOneButton.tag = 201
			dv.zoneTwoButton.tag = 202
			dv.zoneThreeButton.tag = 203
			dv.zoneFourButton.tag = 204
			dv.zoneFiveButton.tag = 205
			dv.zoneSixButton.tag = 206
			break
		case .Home:
			let alert = createAlert(title: "Oops", message: "Something has gone wrong here. Please close and try restarting the app. If issue persists please contact the developer", actionTitle: "OK")
			present(alert, animated: true)
			dismiss(animated: true, completion: nil)
			break
		}
		switch deviceType {
		case .iPad:
			break
		case .iPhone:
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
		print("SO MOOOVVVEE!!!")
	}
	
	@objc func changeLabels() {
		guard let viewState = viewUseState else {return}
		switch viewState {
		case .Timer:
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
		case .Deals:
			
			break
		case .Home:
			break
		}
		
	}
	
	//MARK:- DealSelectionView Selectors
	
	@objc func changePlaylistSelection(_ sender: UIButton) {
		switch sender.tag {
		case 101:
			print("tapped button one")
			dealsView.playlistLabel.text = "Playlist 1"
			interrupt = Interrupt.playListOne
		case 102:
			print("tapped button two")
			dealsView.playlistLabel.text = "Playlist 2"
			interrupt = Interrupt.playListTwo
		case 103:
			print("tapped button three")
			dealsView.playlistLabel.text = "Playlist 3"
			interrupt = Interrupt.playListThree
		default:
			break
		}
	}
	
	@objc func changeZoneLabel(_ sender: UIButton) {
		switch sender.tag {
		case 201:
			print("tapped zone one")
			dealsView.zoneLabel.text = "Zone 1"
			playerGroup = PlayerGroupName.Zone1
			break
		case 202:
			print("tapped zone two")
			dealsView.zoneLabel.text = "Zone 2"
			playerGroup = PlayerGroupName.Zone2
			break
		case 203:
			print("tapped zone three")
			dealsView.zoneLabel.text = "Zone 3"
			playerGroup = PlayerGroupName.Zone3
			break
		case 204:
			print("tapped zone four")
			dealsView.zoneLabel.text = "Zone 4"
			playerGroup = PlayerGroupName.Zone4
			break
		case 205:
			print("tapped zone five")
			dealsView.zoneLabel.text = "Zone 5"
			playerGroup = PlayerGroupName.Zone5
			break
		case 206:
			print("tapped zone six")
			dealsView.zoneLabel.text = "Zone 6"
			playerGroup = PlayerGroupName.Zone6
			break
		default:
			break
		}
	}
	
}

extension PopUpCardViewController: Storyboarded {
	
}
