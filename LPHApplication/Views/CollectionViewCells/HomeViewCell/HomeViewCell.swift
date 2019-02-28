//
//  HomeViewCellCollectionViewCell.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
	
	//MARK:- Outlets
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var infoText: UITextView!
	@IBOutlet weak var identifierImage: UIImageView!
	@IBOutlet weak var backgroundGradient: UIImageView!
	@IBOutlet weak var cornerRadiusView: UIView!
	
	var cornerRadius: CGFloat = 20
	
	//MARK:- Methods
	override func awakeFromNib() {
		infoText.backgroundColor = .clear
		self.layer.shadowOpacity = 0.8
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: -1)
		self.layer.masksToBounds = false
		cornerRadiusView.layer.cornerRadius = cornerRadius
		backgroundGradient.layer.cornerRadius = cornerRadius
		cornerRadiusView.clipsToBounds = true
		backgroundGradient.clipsToBounds = true

	}
	
	func configure(with data: Features) {
		title.text = data.name
		infoText.text = data.infoText
		identifierImage.image = UIImage(named: data.image)
	}
	
}
