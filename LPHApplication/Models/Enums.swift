//
//  Enums.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit


enum CollectionViewCellIdentifiers {
	case HomeViewCell
	case TimeScreenCell
	var identifier: String {
		switch self {
		case .HomeViewCell:
			return "HomeViewCell"
		case .TimeScreenCell:
			return "TimeScreenViewCell"
		}
	}
}

enum ViewControllerNibIdentifiers {
	case popUpCardViewController
	
	var identifier: String {
		return "PopUpCardViewController"
	}
}

enum PopUpCardViewState {
	case extended
	case collapsed
}

