//
//  BodyMeasurementsViewController.swift
//  testing
//
//  Created by Austin Leung on 2/3/21.
//

import UIKit

class CellClass: UITableViewCell {
    
}



class BodyMeasurementsViewController: UIViewController {
    
    @IBOutlet weak var selectAgeButton: UIButton!
    @IBOutlet weak var selectGenderButton: UIButton!
    @IBOutlet weak var selectWeightButton: UIButton!
    @IBOutlet weak var selectHeightButton: UIButton!
    @IBOutlet weak var selectExerciseButton: UIButton!
    
    // dropdown setup
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cells")
        // Do any additional setup after loading the view.
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
            
    }
    
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
    @IBAction func onClickSelectAge(_ sender: Any) {
        //dataSource = Constants.intList.ageList
        selectedButton = selectAgeButton
        addTransparentView(frames: selectAgeButton.frame)
    }
    
    @IBAction func onClickSelectGender(_ sender: Any) {
        selectedButton = selectGenderButton
        addTransparentView(frames: selectGenderButton.frame)
    }
    
    @IBAction func onClickSelectWeight(_ sender: Any) {
        dataSource = Constants.intList.weightList
        selectedButton = selectWeightButton
        addTransparentView(frames: selectWeightButton.frame)
    }
    
    @IBAction func onClickSelectHeight(_ sender: Any) {
        dataSource = Constants.intList.heightList
        selectedButton = selectHeightButton
        addTransparentView(frames: selectHeightButton.frame)
    }
    
    @IBAction func onClickSelectExercise(_ sender: Any) {
        selectedButton = selectExerciseButton
        addTransparentView(frames: selectExerciseButton.frame)
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

extension BodyMeasurementsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath)
        cell.textLabel?.text = String(dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(String(dataSource[indexPath.row]), for: .normal)
        removeTransparentView()
    }
    
}
