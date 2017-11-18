//
//  MainTabBarController.swift
//  MealMall
//
//  Created by Tim on 13.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllers = getViewControllers()
        self.setViewControllers(viewControllers, animated: false)
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1))
        v.backgroundColor = UIColor.lightGray
        self.tabBar.addSubview(v)
    }
    
    
    func getViewControllers() -> [UIViewController] {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let restaurantsVC = RestaurantsViewController(collectionViewLayout: layout)
        let mainVC = UINavigationController(rootViewController: restaurantsVC)
        mainVC.tabBarItem = UITabBarItem(title: "Main", image: #imageLiteral(resourceName: "home"), tag: 1)
        let discoverVC = UIViewController()
        discoverVC.view.backgroundColor = UIColor.green
        discoverVC.tabBarItem = UITabBarItem(title: "Discover", image: #imageLiteral(resourceName: "discover"), tag: 2)
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .vertical
        let checkoutVC = CheckoutViewController(collectionViewLayout: layout2)
        checkoutVC.title = "Checkout"
        let checkoutNav = UINavigationController(rootViewController: checkoutVC)
        
        checkoutNav.tabBarItem = UITabBarItem(title: "Checkout", image: #imageLiteral(resourceName: "bag"), tag: 2)
        return [mainVC, discoverVC, checkoutNav]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
