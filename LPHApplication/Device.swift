//
//  Device.swift
//  LPHApplication
//
//  Created by Tom Murray on 01/04/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

struct DeviceType {
	static let isiPad = UIDevice.current.userInterfaceIdiom == .pad
	static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
}
