//
//  ViewController.swift
//  Lab_8.4
//
//  Created by Admin on 07.06.17.
//  Copyright © 2017 Oleg Kiselevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var harryPotter: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showInfoAboutNotGrowUp(_ sender: Any) {
        let filePath = Bundle.main.path(forResource: "Library", ofType: "plist")
        
        let items = NSArray(contentsOfFile: filePath!)as! [[String:String]]
        
        let item = items[3]
        
        let desc = item["description"]
        let img = item["image"]
        let alert = UIAlertController(title: "Описание книги:", message: desc, preferredStyle: UIAlertControllerStyle.alert)
        
        let image = UIImage(named: img!);
        alert.addImage(image: image!)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func showInfoAbout1984(_ sender: Any) {
        let filePath = Bundle.main.path(forResource: "Library", ofType: "plist")
        
        let items = NSArray(contentsOfFile: filePath!)as! [[String:String]]
        
        let item = items[2]
        
        let desc = item["description"]
        let img = item["image"]
        let alert = UIAlertController(title: "Описание книги:", message: desc, preferredStyle: UIAlertControllerStyle.alert)
        
        let image = UIImage(named: img!);
        alert.addImage(image: image!)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }

    
    
    @IBAction func showInfoAboutInDark(_ sender: Any)
    {
        let filePath = Bundle.main.path(forResource: "Library", ofType: "plist")
        
        let items = NSArray(contentsOfFile: filePath!)as! [[String:String]]
        
        let item = items[1]
        
        let desc = item["description"]
        let img = item["image"]
        let alert = UIAlertController(title: "Описание книги:", message: desc, preferredStyle: UIAlertControllerStyle.alert)
        
        let image = UIImage(named: img!);
        alert.addImage(image: image!)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func showInfoAboutHarryPotter(_ sender: Any)
    {
        let filePath = Bundle.main.path(forResource: "Library", ofType: "plist")
        
        let items = NSArray(contentsOfFile: filePath!)as! [[String:String]]

        let item = items[0]
        
        let desc = item["description"]
        let img = item["image"]
        let alert = UIAlertController(title: "Описание книги:", message: desc, preferredStyle: UIAlertControllerStyle.alert)
        
        let image = UIImage(named: img!);
        alert.addImage(image: image!)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}


