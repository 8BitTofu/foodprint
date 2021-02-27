//
//  HomeViewController.swift
//  testing
//
//  Created by Austin Leung on 2/19/21.
//  Date/Time code provided by Stack Overflow user LorenzOliveto
//  https://stackoverflow.com/questions/35700281/date-format-in-swift
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topBackground: UIView!
    
    @IBOutlet weak var topBar: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var calorieCountLabel: UILabel!
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change background color
        self.view.backgroundColor = Constants.appColors.blond
        topBackground.backgroundColor = Constants.appColors.pearlAqua
        topBar.backgroundColor = Constants.appColors.chineseOrange

        dateLabel.textColor = Constants.appColors.softBlack
        calorieLabel.textColor = Constants.appColors.softBlack
        calorieCountLabel.textColor = Constants.appColors.softBlack
        
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "MM.dd.yyyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        NSLog("%@", dateString)
        
        dateLabel.text = dateString
        
        // Do any additional setup after loading the view.
    }
    

}


