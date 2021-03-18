//
//  ToDoList.swift
//  TaskMatrix
//
//  Created by Takahito Yamada on 2021/01/13.
//

import UIKit

class ToDoList: UIViewController{
    
    var monthlyTasks = UserDefaults.standard.object(forKey: "monthlyTasks") as? [Dictionary<String, String>]
    var weeklyTasks = UserDefaults.standard.object(forKey: "weeklyTasks") as? [Dictionary<String, String>]
    var dailyTasks = UserDefaults.standard.object(forKey: "dailyTasks") as? [Dictionary<String, String>]
    var unimportantTasks = UserDefaults.standard.object(forKey: "unimportantTasks") as? [Dictionary<String, String>]
    
    @IBOutlet weak var toDoListTableView: UITableView!
    
    var addBarButtonItem: UIBarButtonItem!
    var editBarButtonItem: UIBarButtonItem!
    let sections = ["今月やること", "今週やること", "今日やること", "重要でないこと"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        
        setBarButtonItem()
        observeUserDefault()
    }
    
    func setBarButtonItem() {
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc func addTask() {
        let storyboard = UIStoryboard(name: "AddTask", bundle: nil)
        let addTaskVC = storyboard.instantiateViewController(withIdentifier: "addTask")
        present(addTaskVC, animated: true, completion: nil)
    }
    
    func observeUserDefault() {
        UserDefaults.standard.addObserver(self, forKeyPath: "monthlyTasks", options: [.new, .old], context: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: "weeklyTasks", options: [.new, .old], context: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: "dailyTasks", options: [.new, .old], context: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: "unimportantTasks", options: [.new, .old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let tasks = UserDefaults.standard.object(forKey: keyPath ?? "") as? [Dictionary<String, String>] ?? [[:]]
        switch keyPath {
        case "monthlyTasks":
            monthlyTasks = tasks
        case "weeklyTasks":
            weeklyTasks = tasks
        case "dailyTasks":
            dailyTasks = tasks
        case "unimportantTasks":
            unimportantTasks = tasks
        default:
            print("nothing to do")
        }
        toDoListTableView.reloadData()
    }
    
}

extension ToDoList: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return monthlyTasks?.count ?? 0
        }else if section == 1 {
            return weeklyTasks?.count ?? 0
        }else if section == 2 {
            return dailyTasks?.count ?? 0
        }else if section == 3{
            return unimportantTasks?.count ?? 0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoListTableView.dequeueReusableCell(withIdentifier: "toDoListTableViewCell", for: indexPath) as! ToDoListTableViewCell
        if indexPath.section == 0 {
            
            let monthlyTasksDic = monthlyTasks?[indexPath.row]
            cell.taskType = "hhTasks"
            cell.taskNumber = indexPath.row
            cell.task = monthlyTasksDic?["task"] ?? ""
            cell.complete = monthlyTasksDic?["complete"] ?? "incomplete"
            
        }else if indexPath.section == 1 {
            
            let weeklyTasksDic = weeklyTasks?[indexPath.row]
            cell.taskType = "weeklyTasks"
            cell.taskNumber = indexPath.row
            cell.task = weeklyTasksDic?["task"] ?? ""
            cell.complete = weeklyTasksDic?["complete"] ?? "incomplete"
            
        }else if indexPath.section == 2 {
            
            let dailyTasksDic = dailyTasks?[indexPath.row]
            cell.taskType = "dailyTasks"
            cell.taskNumber = indexPath.row
            cell.task = dailyTasksDic?["task"] ?? ""
            cell.complete = dailyTasksDic?["complete"] ?? "incomplete"
            
        }else if indexPath.section == 3 {
            
            let unimportantTasksDic = unimportantTasks?[indexPath.row]
            cell.taskType = "unimportantTasks"
            cell.taskNumber = indexPath.row
            cell.task = unimportantTasksDic?["task"] ?? ""
            cell.complete = unimportantTasksDic?["complete"] ?? "incomplete"
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detail = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        switch indexPath.section {
        case 0:
            detail.taskName = monthlyTasks?[indexPath.row]["task"] ?? ""
            detail.matrix = "monthlyTasks"
            detail.taskNumber = indexPath.row
            detail.detail = monthlyTasks?[indexPath.row]["detail"] ?? ""
        case 1:
            detail.taskName = weeklyTasks?[indexPath.row]["task"] ?? ""
            detail.matrix = "weeklyTasks"
            detail.taskNumber = indexPath.row
            detail.detail = weeklyTasks?[indexPath.row]["detail"] ?? ""
        case 2:
            detail.taskName = dailyTasks?[indexPath.row]["task"] ?? ""
            detail.matrix = "dailyTasks"
            detail.taskNumber = indexPath.row
            detail.detail = dailyTasks?[indexPath.row]["detail"] ?? ""
        case 3:
            detail.taskName = unimportantTasks?[indexPath.row]["task"] ?? ""
            detail.matrix = "unimportantTasks"
            detail.taskNumber = indexPath.row
            detail.detail = unimportantTasks?[indexPath.row]["detail"] ?? ""
        default:
            print("nothing to do")
        }
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detail, animated: true)
        hidesBottomBarWhenPushed = false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            monthlyTasks?.remove(at: indexPath.row)
            UserDefaults.standard.set(monthlyTasks, forKey: "monthlyTasks")
        }else if indexPath.section == 1 {
            weeklyTasks?.remove(at: indexPath.row)
            UserDefaults.standard.set(weeklyTasks, forKey: "weeklyTasks")
        }else if indexPath.section == 2 {
            dailyTasks?.remove(at: indexPath.row)
            UserDefaults.standard.set(dailyTasks, forKey: "dailyTasks")
        }else if indexPath.section == 3 {
            unimportantTasks?.remove(at: indexPath.row)
            UserDefaults.standard.set(unimportantTasks, forKey: "unimportantTasks")
        }
    }
    
}

class ToDoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    let defaultImage = UIImage(named: "unselected")
    let tappedImage = UIImage(named: "selected")
    
    var taskType:String = ""
    
    var taskNumber:Int = 0
    
    var task: String = ""{
        didSet {
            taskLabel.text = task
        }
    }
    
    var complete: String = "" {
        didSet {
            if "complete" == complete {
                checkButton.setImage(tappedImage, for: .normal)
            }else {
                checkButton.setImage(defaultImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        checkButton.addTarget(self, action: #selector(tappedCheckButton), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @objc func tappedCheckButton() {
        if complete == "complete"{
            var tasks = UserDefaults.standard.object(forKey: "\(taskType)") as? [Dictionary<String, String>] ?? [[:]]
            tasks[taskNumber]["complete"] = "incomplete"
            UserDefaults.standard.setValue(tasks, forKey: "\(taskType)")
            complete = "incomplete"
            
        }else {
            
            var tasks = UserDefaults.standard.object(forKey: taskType) as? [Dictionary<String, String>] ?? [[:]]
            tasks[taskNumber]["complete"] = "complete"
            UserDefaults.standard.setValue(tasks, forKey: taskType)
            complete = "complete"
        }
    }
    
}
