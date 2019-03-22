//
//  SendNetworkRequestButton.swift
//  LPHApplication
//
//  Created by Tom Murray on 18/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit



class SendNetworkRequestButton: UIButton {
	
	@IBOutlet weak  var buttonView: UIButton!

	override init(frame: CGRect) {
		super.init(frame: frame)
		privateInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		privateInit()
	}
	
	private func privateInit() {
		Bundle.main.loadNibNamed("SendNetworkRequestButton", owner: self, options: nil)
		self.addSubview(self.buttonView)
		self.buttonView.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
		self.buttonView.layer.cornerRadius = 10.0
	}
	
	@IBAction func didTapSend(_ sender: Any) {
		print("tapped to send network request")
	}
	
}
