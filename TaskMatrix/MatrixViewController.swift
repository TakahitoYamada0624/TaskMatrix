//
//  MatrixViewController.swift
//  TaskMatrix
//
//  Created by Takahito Yamada on 2021/02/10.
//

import UIKit

class MatrixViewController: UIViewController {
    
    @IBOutlet weak var monthlyTasksView: UIView!
    @IBOutlet weak var weeklyTasksView: UIView!
    @IBOutlet weak var dailyTasksView: UIView!
    @IBOutlet weak var unimportantTasksView: UIView!
    
    let rgbaColor = RGBAColor()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMonthlyTasksView()
        setupWeeklyTasksView()
        setupDailyTasksView()
        setupUnimportantTasksView()
    }
    
    func setupMonthlyTasksView() {
        monthlyTasksView.backgroundColor = rgbaColor.rgba(red: 255, green: 0, blue: 0, alpha: 0.2)
        for a in 1...6 {
            let label = monthlyTasksView.viewWithTag(a) as! UILabel
            label.text = ""
        }
        guard let monthlyTasks = UserDefaults.standard.object(forKey: "monthlyTasks") as? [Dictionary<String, String>] else {return}
        for (number, task) in monthlyTasks.enumerated() {
            if (number + 1) > 6 {
                return
            }
            let tag = number + 1
            let label = monthlyTasksView.viewWithTag(tag) as! UILabel
            guard let taskName = task["task"] else {return}
            label.text = "・\(taskName)"
        }
    }
    
    func setupWeeklyTasksView() {
        for a in 1...6 {
            let label = weeklyTasksView.viewWithTag(a) as! UILabel
            label.text = ""
        }
        weeklyTasksView.backgroundColor = rgbaColor.rgba(red: 255, green: 255, blue: 0, alpha: 0.2)
        guard let weeklyTasks = UserDefaults.standard.object(forKey: "weeklyTasks") as? [Dictionary<String, String>] else {return}
        for (number, task) in weeklyTasks.enumerated() {
            if (number + 1) > 6 {
                return
            }
            let tag = number + 1
            let label = weeklyTasksView.viewWithTag(tag) as! UILabel
            guard let taskName = task["task"] else {return}
            label.text = "・\(taskName)"
        }
    }
    
    func setupDailyTasksView() {
        dailyTasksView.backgroundColor = rgbaColor.rgba(red: 0, green: 0, blue: 255, alpha: 0.2)
        for a in 1...6 {
            let label = dailyTasksView.viewWithTag(a) as! UILabel
            label.text = ""
        }
        guard let dailyTasks = UserDefaults.standard.object(forKey: "dailyTasks") as? [Dictionary<String, String>] else {return}
        for (number, task) in dailyTasks.enumerated() {
            if (number + 1) > 6 {
                return
            }
            let tag = number + 1
            let label = dailyTasksView.viewWithTag(tag) as! UILabel
            guard let taskName = task["task"] else {return}
            label.text = "・\(taskName)"
        }
    }
    
    func setupUnimportantTasksView() {
        unimportantTasksView.backgroundColor = rgbaColor.rgba(red: 0, green: 255, blue: 0, alpha: 0.2)
        for a in 1...6 {
            let label = unimportantTasksView.viewWithTag(a) as! UILabel
            label.text = ""
        }
        guard let unimportantTasks = UserDefaults.standard.object(forKey: "unimportantTasks") as? [Dictionary<String, String>] else {return}
        for (number, task) in unimportantTasks.enumerated() {
            if (number + 1) > 6 {
                return
            }
            let tag = number + 1
            let label = unimportantTasksView.viewWithTag(tag) as! UILabel
            guard let taskName = task["task"] else {return}
            label.text = "・\(taskName)"
        }
    }
    
}

