//
//  TimeScreenCell.swift
//  LPHApplication
//
//  Created by Tom Murray on 28/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class TimeScreenViewCell: UICollectionViewCell {
	
	@IBOutlet weak var theatreName: UILabel!
	@IBOutlet weak var timeToGo: UILabel!
	@IBOutlet weak var cornerRadiusView: UIView!
	@IBOutlet weak var backgroundGradient: UIImageView!
	@IBOutlet weak var selectionImage: UIImageView!
	
	var cornerRadius: CGFloat = 20
	var isEditing: Bool = false {
		didSet {
			selectionImage.isHidden = !isEditing
		}
	}
	override var isSelected: Bool {
		didSet {
			if isEditing {
				return selectionImage.image = isSelected ? UIImage(named: "selected") : UIImage(named: "unselected")
			}
		}
	}
	
	override func awakeFromNib() {
		self.layer.shadowOpacity = 0.6
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
		self.layer.masksToBounds = false
		cornerRadiusView.layer.cornerRadius = cornerRadius
		backgroundGradient.layer.cornerRadius = cornerRadius
		cornerRadiusView.clipsToBounds = true
		backgroundGradient.clipsToBounds = true
	}
	
	func configure(with data: TimeSelection) {
		theatreName.text = data.theatrenName
		timeToGo.text = data.timeToGo
	}
	
}
