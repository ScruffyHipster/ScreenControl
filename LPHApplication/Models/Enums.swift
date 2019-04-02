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
			return "DealsViewCell"
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
	case Zone1
	case Zone2
	case Zone3
	case Zone4
	case Zone5
	case Zone6
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
		case .Zone1:
			return 4
		case .Zone2:
			return 5
		case .Zone3:
			return 6
		case .Zone4:
			return 7
		case .Zone5:
			return 8
		case .Zone6:
			return 9
		case .all:
			return 10
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
		case .Zone1:
			return "Zone 1"
		case .Zone2:
			return "Zone 2"
		case .Zone3:
			return "Zone 3"
		case .Zone4:
			return "Zone 4"
		case .Zone5:
			return "Zone 5"
		case .Zone6:
			return "Zone 6"
		}
	}
}

enum Interrupt {
	case oneMinuteSign
	case fiveMinuteSign
	case tenMinuteSign
	case playListOne
	case playListTwo
	case playListThree
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
		case .playListOne:
			//sends letter E
			return 4719
		case .playListTwo:
			//sends letter F
			return 4720
		case .playListThree:
			//sends letter G
			return 4721
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
		case .playListOne:
			return "Playlist 1"
		case .playListTwo:
			return "Playlist 2"
		case .playListThree:
			return "Playlist 3"
		}
	}
}

enum UsableColors {
	case grey
	case lightGrey
	
	var rgbValue: UIColor {
		switch self {
		case .grey:
			return UIColor(red: 112 / 255, green: 112 / 255, blue: 112 / 255, alpha: 1.0)
		case .lightGrey:
			return UIColor(red: 193 / 255, green: 193 / 255, blue: 193 / 255, alpha: 1.0)
		}
	}
}

enum DeviceTypeModel {
	case iPhone
	case iPad
}
