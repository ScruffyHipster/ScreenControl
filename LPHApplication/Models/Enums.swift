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
	var identifier: String {
		switch self {
		case .HomeViewCell:
			return "HomeViewCell"
		}
	}
}
