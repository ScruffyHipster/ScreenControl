//
//  CollectionViewDataSource.swift
//  LPHApplication
//
//  Created by Tom Murray on 27/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit


class CollectionViewDataSource: NSObject, DataHandler {

	var dataArray: [AnyObject]?
	
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
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.HomeViewCell.identifier, for: indexPath) as! HomeViewCell
		guard let data = dataArray as? [Features] else {return cell}
		let feature = data[indexPath.row]
		cell.configure(with: feature)
		return cell
	}
}

extension CollectionViewDataSource: UICollectionViewDelegateFlowLayout {
	
}
