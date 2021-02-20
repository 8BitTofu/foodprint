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
        
        // get date/time
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: "2016-02-29 12:24:26") {
            print(dateFormatterPrint.string(from: date))
            dateLabel.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        
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
