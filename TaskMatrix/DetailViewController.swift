//
//  DetailViewController.swift
//  TaskMatrix
//
//  Created by Takahito Yamada on 2021/02/09.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    let rgbaColor = RGBAColor()
    
    var taskName: String = ""
    var matrix: String = ""
    var taskNumber: Int = 0
    var detail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskLabel.text = taskName
        detailTextView.backgroundColor = rgbaColor.rgba(red: 230, green: 230, blue: 230, alpha: 0.2)
        saveButton.backgroundColor = rgbaColor.rgba(red: 220, green: 0, blue: 0, alpha: 0.5)
        saveButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailTextView.text = detail
    }
    
    @IBAction func saveText(_ sender: Any) {
        var task = UserDefaults.standard.object(forKey: matrix) as? [Dictionary<String, String>]
        task?[taskNumber]["detail"] = detailTextView.text
        UserDefaults.standard.set(task, forKey: matrix)
        navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
