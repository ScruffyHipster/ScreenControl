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
	@IBOutlet weak var emergencyInitiateButton: UIButton!
	@IBOutlet weak var sendButton: UIButton! {
		didSet {
			self.sendButton.lphSystemButton(title: "Send")
		}
	}
	@IBOutlet weak var cancelButton: UIButton!
	
	
	//MARK:- Properties
	weak var coordinator: MainCoordinator?
	weak var tempCoordinator: EmergencyCoordinator?
	var emergency: Bool = false {
		didSet {
			sendButton.isEnabled = self.emergency ? true : false
			emergencyInitiateButton.imageView?.image = self.emergency ? UIImage(named: "powerButtonOn") : UIImage(named: "powerButtonOff")
		}
	}
	lazy var activitySpinner: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .whiteLarge)
		view.color = UsableColors.grey.rgbValue
		view.startAnimating()
		return view
	}()
	let playerGroup: PlayerGroupName = .all
	let interrupt: Interrupt = .emergency
	let cancel: Interrupt = .cancel
	var deviceType: DeviceTypeModel?
	

	
	//MARK:- Actions
	@IBAction func didTapSendButton(_ sender: Any) {
		activitySpinner.layer.position.x = self.view.bounds.size.width / 2
		activitySpinner.layer.position.y = self.cancelButton.layer.position.y - 30
		view.addSubview(activitySpinner)
		coordinator?.httpRequest(group: playerGroup, interrupt: interrupt)
		UIView.animate(withDuration: 0.5) {
			self.sendButton.isHidden = self.emergency
			self.sendButton.isEnabled = !self.emergency
			self.cancelButton.isHidden = !self.emergency
			self.cancelButton.isEnabled = self.emergency
			
		}
	}
	
	@IBAction func didTapCancelButton(_ sender: Any) {
		let alert = UIAlertController(title: "Cancel the request", message: "Are you sure you want to cancel the emergency request", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
			self.coordinator?.networking.cancelTask()
			self.emergency = !self.emergency
			UIView.animate(withDuration: 0.5) {
				self.sendButton.isHidden = self.emergency
				self.sendButton.isEnabled = !self.emergency
				self.cancelButton.isHidden = !self.emergency
				self.cancelButton.isEnabled = !self.emergency
			}
		}))
		present(alert, animated: true)
	}
	
	@IBAction func didTapEmergencyInitButton(_ sender: Any) {
		if !emergency {
			let alert = UIAlertController(title: "Emergency", message: "Are you sure you want to trigger the emergency messaging?", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (_) in
				self.emergencyInfoLabel.text = "Please tap send to finalise messaging"
				self.emergency = true
			}))
			alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
				print("Cancelled")
				self.emergency = false
			}))
			present(alert, animated: true)
		} else {
			let alert = UIAlertController(title: "Emergency", message: "Are you sure you want to remove the emergency messaging?", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (_) in
				self.emergency = false
				self.sendButton.isHidden = false
				self.emergencyInfoLabel.text = "In the event of an emergency. Tap button below to initiate emergency screen content"
			}))
			alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
				print("Cancelled")
				self.emergency = true
			}))
			present(alert, animated: true)
		}
	}

	//MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
	
	func emergencyInProgress() {
		cancelButton.isHidden = true
		activitySpinner.removeFromSuperview()
		emergencyInfoLabel.text = "Emergency in progress"
	}
	
	

}

//MARK:- Storyboarded
extension EmergencyViewController: Storyboarded {
	
}
