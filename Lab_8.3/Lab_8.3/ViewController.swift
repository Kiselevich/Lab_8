//
//  ViewController.swift
//  Lab_8.3
//
//  Created by Admin on 07.06.17.
//  Copyright © 2017 Oleg Kiselevich. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var studentNameTextField: UITextField!
    
    var students = [Students]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        let student = students[indexPath.row];
        cell.textLabel?.text = student.value(forKey: "name") as? String
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let result = try context.fetch(Students.fetchRequest())
            students = result as! [Students]
        } catch let error as NSError {
            print("\(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt  indexPath: IndexPath)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            context.delete(students[indexPath.row])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                let result = try context.fetch(Students.fetchRequest())
                students = result as! [Students]
                self.tableView.reloadData()
            } catch let error as NSError {
                print("\(error)")
            }
        }
    }
    
    
    @IBAction func addStudentButton(_ sender: Any)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let student = Students(entity: Students.entity(), insertInto: context)
        let name = studentNameTextField.text
        student.setValue(name, forKey: "name")
        do {
            try context.save()
            students.append(student)
            self.tableView.reloadData()
        } catch let error as NSError {
            print("\(error)")
        }
    }
}
