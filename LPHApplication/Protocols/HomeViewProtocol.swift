//
//  HomeViewProtocol.swift
//  LPHApplication
//
//  Created by Tom Murray on 02/04/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewProtocol {
	var mainCoordinator: MainCoordinator? {get set}
	var collectionViewDataSource: CollectionViewDataSource {get set}
}

