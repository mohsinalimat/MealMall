//
//  RestaurantsViewController.swift
//  MealMall
//
//  Created by Tim on 13.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

let RestCellID = "RestCell"

class RestaurantsViewController: UICollectionViewController {
    
    var restaurantDatasource: RestaurantDatasource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white

        // Register cell classes
        restaurantDatasource = RestaurantDatasource()
//        restaurantDatasource?.populateDatabase()
        restaurantDatasource?.attemptFetch()
        collectionView?.dataSource = restaurantDatasource
        self.collectionView!.register(RestaurantCell.self, forCellWithReuseIdentifier: RestCellID)
        
        collectionView?.register(CarouselHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CarouselHeaderCell.ID)

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 120)
        }
        return CGSize.zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MenuViewController()

        vc.restaurant = restaurantDatasource!.controller.fetchedObjects![indexPath.row]
        self.navigationItem.title = ""
//        vc.title = vc.restaurant.name!
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension RestaurantsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
}
