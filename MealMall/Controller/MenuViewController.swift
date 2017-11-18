//
//  MenuViewController.swift
//  MealMall
//
//  Created by Tim on 19.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import ExpandableCell




class MenuViewController: UIViewController {
    
    var restaurant: Restaurant!
    var expandableDelegate: MenuDatasource!
    
    lazy var menuTable: ExpandableTableView = {
        let table = ExpandableTableView(frame: self.view.frame, style: .plain)
//        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expandableDelegate = MenuDatasource(restaurant: restaurant)
        expandableDelegate.attemptFetch()
        menuTable.animation = .fade
        menuTable.expandableDelegate = expandableDelegate

        menuTable.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.ID)
        menuTable.register(DishCell.self, forCellReuseIdentifier: DishCell.ID)
        setupTable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        menuTable.closeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.menuTable.reloadData()
    }
    
    func setupTable() {
        view.addSubview(menuTable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

