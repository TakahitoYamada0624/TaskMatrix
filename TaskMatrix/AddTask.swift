//
//  AddTask.swift
//  TaskMatrix
//
//  Created by Takahito Yamada on 2021/01/17.
//

import UIKit

class AddTask: UIViewController {
    
    var monthlyTasks = UserDefaults.standard.object(forKey: "monthlyTasks") as? [Dictionary<String, String>]
    var weeklyTasks = UserDefaults.standard.object(forKey: "weeklyTasks") as? [Dictionary<String, String>]
    var dailyTasks = UserDefaults.standard.object(forKey: "dailyTasks") as? [Dictionary<String, String>]
    var unimportantTasks = UserDefaults.standard.object(forKey: "unimportantTasks") as? [Dictionary<String, String>]
    
    var choicedNumber: Int = 0
    var rgbaColor = RGBAColor()
    
    let selectedImage = UIImage(named: "selected")
    let unselectedImage = UIImage(named: "unselected")
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var fourthChoiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTextField.delegate = self
        setupView()
        setupChoiceButton()
    }
    
    func setupView() {
        addTaskButton.addTarget(self, action: #selector(touchedAddTaskButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(touchedCancelButton), for: .touchUpInside)
        addTaskButton.backgroundColor = rgbaColor.rgba(red: 220, green: 0, blue: 0, alpha: 0.5)
        addTaskButton.layer.cornerRadius = 10
    }
    
    func setupChoiceButton() {
        firstChoiceButton.setImage(unselectedImage, for: .normal)
        secondChoiceButton.setImage(unselectedImage, for: .normal)
        thirdChoiceButton.setImage(unselectedImage, for: .normal)
        fourthChoiceButton.setImage(unselectedImage, for: .normal)
        firstChoiceButton.addTarget(self, action: #selector(touchedFirstChoiceButton), for: .touchUpInside)
        secondChoiceButton.addTarget(self, action: #selector(touchedSecondChoiceButton), for: .touchUpInside)
        thirdChoiceButton.addTarget(self, action: #selector(touchedthirdChoiceButton), for: .touchUpInside)
        fourthChoiceButton.addTarget(self, action: #selector(touchedfourthChoiceButton), for: .touchUpInside)
    }
    
    @objc func touchedAddTaskButton() {
        guard let task = taskTextField.text else {return}
        
        switch choicedNumber {
        case 1:
            if monthlyTasks == nil {
                createTask(matrix: "monthlyTasks" , task: task)
            }else {
                let createdTask = ["matrix": "hhTasks", "task": task, "complete": "incomplete", "detail": ""]
                monthlyTasks?.append(createdTask)
                UserDefaults.standard.set(monthlyTasks, forKey: "monthlyTasks")
                dismiss(animated: true, completion: nil)
            }
        case 2:
            if weeklyTasks == nil {
                createTask(matrix: "weeklyTasks", task: task)
            }else {
                let createdTask = ["matrix": "hrTasks", "task": task, "complete": "incomplete", "detail": ""]
                weeklyTasks?.append(createdTask)
                UserDefaults.standard.set(weeklyTasks, forKey: "weeklyTasks")
                dismiss(animated: true, completion: nil)
            }
        case 3:
            if dailyTasks == nil {
                createTask(matrix: "dailyTasks", task: task)
            }else {
                let createdTask = ["matrix": "rhTasks", "task": task, "complete": "incomplete", "detail": ""]
                dailyTasks?.append(createdTask)
                UserDefaults.standard.set(dailyTasks, forKey: "dailyTasks")
                dismiss(animated: true, completion: nil)
            }
        case 4:
            if unimportantTasks == nil {
                createTask(matrix: "unimportantTasks", task: task)
            }else {
                let createdTask = ["matrix": "rrTasks", "task": task, "complete": "incomplete", "detail": ""]
                unimportantTasks?.append(createdTask)
                UserDefaults.standard.set(unimportantTasks, forKey: "unimportantTasks")
                dismiss(animated: true, completion: nil)
            }
        default:
            showAlert()
        }
    }
    
    func createTask(matrix: String, task: String) {
        let createdTask = ["matrix": matrix, "task": task, "complete": "incomplete", "detail": ""]
        UserDefaults.standard.set([createdTask], forKey: matrix)
        dismiss(animated: true, completion: nil)
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "タスクの種類を選択してください", message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func touchedCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func touchedFirstChoiceButton() {
        firstChoiceButton.setImage(selectedImage, for: .normal)
        secondChoiceButton.setImage(unselectedImage, for: .normal)
        thirdChoiceButton.setImage(unselectedImage, for: .normal)
        fourthChoiceButton.setImage(unselectedImage, for: .normal)
        choicedNumber = 1
    }
    
    @objc func touchedSecondChoiceButton() {
        secondChoiceButton.setImage(selectedImage, for: .normal)
        firstChoiceButton.setImage(unselectedImage, for: .normal)
        thirdChoiceButton.setImage(unselectedImage, for: .normal)
        fourthChoiceButton.setImage(unselectedImage, for: .normal)
        choicedNumber = 2
    }
    
    @objc func touchedthirdChoiceButton() {
        thirdChoiceButton.setImage(selectedImage, for: .normal)
        firstChoiceButton.setImage(unselectedImage, for: .normal)
        secondChoiceButton.setImage(unselectedImage, for: .normal)
        fourthChoiceButton.setImage(unselectedImage, for: .normal)
        choicedNumber = 3
    }
    
    @objc func touchedfourthChoiceButton() {
        fourthChoiceButton.setImage(selectedImage, for: .normal)
        firstChoiceButton.setImage(unselectedImage, for: .normal)
        secondChoiceButton.setImage(unselectedImage, for: .normal)
        thirdChoiceButton.setImage(unselectedImage, for: .normal)
        choicedNumber = 4
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension AddTask: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskTextField.resignFirstResponder()
        return true
    }
}
