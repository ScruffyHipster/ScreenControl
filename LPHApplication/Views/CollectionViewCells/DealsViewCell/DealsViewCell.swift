//
//  DealsViewCell.swift
//  LPHApplication
//
//  Created by Tom Murray on 06/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class DealsViewCell: UICollectionViewCell {
	
	//Outlets
	@IBOutlet weak var cornerRadiusView: UIView!
	@IBOutlet weak var backgroundGradient: UIImageView!
	@IBOutlet weak var dealTitleLabel: UILabel!
	@IBOutlet weak var zoneTitleLabel: UILabel!
	@IBOutlet weak var selectionImage: UIImageView!
	
	//Properties
	
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
	var cornerRadius: CGFloat = 20
	
	//Methods
	
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
	
	func configure(with data: DealSelection) {
		zoneTitleLabel.text = data.zoneName
		dealTitleLabel.text = data.playlistName
	}
}
