//
//  HomeViewController.swift
//  testing
//
//  Created by Austin Leung on 2/17/21.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        
        // menu comes from left side
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        // add swiping functionality
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func menuTapped() {
        present(menu!, animated: true)
    }
}


class MenuListController: UITableViewController {
    // menu items
    var menuItems = ["Option 1", "Option 2", "Option 3", "Option 4", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = Constants.appColors.buttonColor
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // number of rows ??
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // set cell to menu item
        cell.textLabel?.text = menuItems[indexPath.row]
        
        // coloration
        cell.textLabel?.textColor = .white
        cell.backgroundColor = Constants.appColors.buttonColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // do something in each button here
    }
}
