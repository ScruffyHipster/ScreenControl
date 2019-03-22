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
	case Home
}

enum PopUpCardViewState {
	case extended
	case collapsed
}

enum PlayerGroupName {
	case TheatreOne
	case TheatreTwo
	case TheatreThree
	case all
	
	var playerGroupIdentifier: Int {
		//numbers refer to the group on SL
		switch self {
		case .TheatreOne:
			return 1
		case .TheatreTwo:
			return 2
		case .TheatreThree:
			return 3
		case .all:
			return 4
		}
	}
	
	var playGroupString: String {
		switch self {
		case .TheatreOne:
			return "Theatre One"
		case .TheatreTwo:
			return "Theatre Two"
		case .TheatreThree:
			return "Theatre Three"
		case .all:
			return "All"
		}
	}
}

enum Interrupt {
	case oneMinuteSign
	case fiveMinuteSign
	case tenMinuteSign
	case emergency
	case cancel
	
	var interruptToSend: Int {
		switch self {
		case .oneMinuteSign:
			//Sends letter C
			return 4717
		case .fiveMinuteSign:
			//Sends letter C
			return 4717
		case .tenMinuteSign:
			//Sends letter C
			return 4717
		case .emergency:
			//Sends letter Y
			return 4720
		case .cancel:
			//sends letter X
			return 4738
		}
	}
	
	var interruptString: String {
		switch self {
		case .oneMinuteSign:
			return "1 Min"
		case .fiveMinuteSign:
			return "5 Min"
		case .tenMinuteSign:
			return "10 Min"
		case .emergency:
			return "Emergency"
		case .cancel:
			//Shouldn't need to use this
			return "Cancel"
		}
	}
}
