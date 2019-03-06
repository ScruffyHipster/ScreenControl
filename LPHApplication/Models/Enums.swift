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
	case DealsScreenCell
	var identifier: String {
		switch self {
		case .HomeViewCell:
			return "HomeViewCell"
		case .TimeScreenCell:
			return "TimeScreenViewCell"
		case .DealsScreenCell:
			return "DealsScreenViewCell"
		}
	}
}

enum ViewControllerNibIdentifiers {
	case popUpCardViewController
	var identifier: String {
		return "PopUpCardViewController"
	}
}

enum UIViewNibIdentifiers {
	case timeViewNib
	case dealViewNib
	var identifier: String {
		switch self {
		case .dealViewNib:
			return "DealsSelectionView"
		case .timeViewNib:
			return "TimeSelectionView"
		}
	}
}

enum ReusableCollectionViewState {
	case Timer
	case Deals
}

enum PopUpCardViewState {
	case extended
	case collapsed
}

