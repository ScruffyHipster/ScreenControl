//
//  CollectionViewDataSource.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit


class CollectionViewDataSource: NSObject {
	
	var dataArray: [AnyObject]?
	var cellToUse: ReusableCollectionViewState?
	
	func populateData<T>(with data: [T]) {
		dataArray = data as [AnyObject]
	}
}

extension CollectionViewDataSource: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let data = dataArray else {return 0}
		//TODO:- Remove print statement
		print(data.count)
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cellToUse = cellToUse else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
			return cell
		}
		switch cellToUse {
		case ReusableCollectionViewState.Home:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.HomeViewCell.identifier, for: indexPath) as! HomeViewCell
			guard let data = dataArray as? [Features] else {return cell}
			let feature = data[indexPath.row]
			cell.configure(with: feature)
			return cell
		case ReusableCollectionViewState.Timer:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.TimeScreenCell.identifier, for: indexPath) as! TimeScreenViewCell
			guard let data = dataArray as? [TimeSelection] else {return cell}
			let feature = data[indexPath.row]
			cell.configure(with: feature)
			return cell
		case ReusableCollectionViewState.Deals:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.DealsScreenCell.identifier, for: indexPath) as! DealsViewCell
			guard let data = dataArray as? [DealSelection] else {return cell}
			let feature = data[indexPath.row]
			cell.configure(with: feature)
			return cell
		}
	}
}

extension CollectionViewDataSource: UICollectionViewDelegateFlowLayout {
	
}
