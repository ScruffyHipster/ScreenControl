//
//  DataSource.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation


struct Features {
	var name: String
	var infoText: String
	var image: String
}

struct TimeSelection {
	var theatrenName: String
	var timeToGo: String
	var theatreGroup: PlayerGroupName
}

struct DealSelection {
	var playlistName: String
	var zoneName: String
	var zoneGroup: PlayerGroupName
}
