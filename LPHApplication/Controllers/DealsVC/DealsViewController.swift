//
//  DealsViewController.swift
//  LPHApplication
//
//  Created by Tom Murray on 05/03/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class DealsViewController: UIViewController {

	
	//MARK:- Properties
	weak var coordinator: MainCoordinator?
	lazy var collectionViewDataSource: CollectionViewDataSource = {
		let ds = CollectionViewDataSource()
		return ds
	}()
	
	//
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DealsViewController: Storyboarded {
	
}
