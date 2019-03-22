//
//  ViewController.swift
//  LPHApplication
//
//  Created by Tom Murray on 25/02/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	weak var mainCoordinator: MainCoordinator?
	var collectionViewDataSource: CollectionViewDataSource = {
		let ds = CollectionViewDataSource()
		ds.populateData(with: homeScreenDataSource)
		ds.cellToUse = ReusableCollectionViewState.Home
		return ds
	}()
	
	//MARK:- Functions
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	func setUpCollectionView() {
		loadNib()
		setUpCollectionViewLayout()
		collectionView.dataSource = collectionViewDataSource
		collectionView.delegate = self
		collectionView.isScrollEnabled = false
	}
	
	func setUpCollectionViewLayout() {
		let width = view.bounds.width - 20
		let height = view.bounds.height / 4
		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: height)
		layout.sectionInset = UIEdgeInsets(top: 20, left: 80, bottom: 20, right: 80)
		layout.minimumLineSpacing = 12.0
		layout.minimumInteritemSpacing = 10.0
	}
	
	func loadNib() {
		let nib = UINib(nibName: CollectionViewCellIdentifiers.HomeViewCell.identifier, bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.HomeViewCell.identifier)
	}
}

//MARK:- CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
	//MARK:- Delegate
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			mainCoordinator?.timeSelection()
		case 1:
			mainCoordinator?.emergencyController()
		default:
			mainCoordinator?.dealsController()
		}
	}
}

extension HomeViewController: Storyboarded {
	
}
