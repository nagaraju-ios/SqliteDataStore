//
//  SCViewController.swift
//  SqliteDataStore
//
//  Created by THOTA NAGARAJU on 12/18/19.
//  Copyright © 2019 THOTA NAGARAJU. All rights reserved.
//

import UIKit
import SQLite

class SCViewController: UIViewController {
// CREATE varabels
    @IBOutlet weak var qualifyTF: UITextField!
    
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var frstNameTF: UITextField!
    var path:String!
    var dconect:Connection!
    var svcTag:Int!
     var totalData = [Int64]()
    
    var qualify = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         CreateTabels()
       // if (ViewController.butonTap == "a"){
           frstNameTF.text = ViewController.FirstName[svcTag]
           lastNameTf.text = ViewController.LastName[svcTag]
           qualifyTF.text = ViewController.Qualify[svcTag]
        //}
   
         }
// CREATE label In SQlite
    func CreateTabels(){
        path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                      do{
               dconect = try
             Connection("\(path!)/naga.sqlite3")
            try! dconect.run("CREATE TABlE IF NOT EXISTS CONTACTS( ID INTEGER PRIMARY KEY AUTOINCREMENT, FIRSTNAME,LASTNAME,QUALIFICATION)")
                          
                 }catch{
                          
               print("something went wrong")
                          
                }
            }
    
// SAVE Contacts fun Of IB ActionButton
    @IBAction func saveBtn(_ sender: Any) {
        
        do{
            
       
            try! dconect.run("INSERT INTO CONTACTS(  FIRSTNAME,LASTNAME,QUALIFICATION)VALUES (?,?,?)",frstNameTF.text!,lastNameTf.text!,qualifyTF.text!)
        }catch{
            
            print( "Not Inserted Data")
        
        
        }
    }
    
   // UPDATE Contacts fun  Of IB ActionButton
    @IBAction func updateBtn(_ sender: Any) {
        
         updateData()
    }
    func  updateData(){
        
        do {
        
          let statment4 = try! dconect!.run ("UPDATE CONTACTS SET FIRSTNAME = '\(frstNameTF.text!)',LASTNAME = '\(lastNameTf.text!)',QUALIFICATION =' \(qualifyTF.text!)' WHERE ID = \(totalData[svcTag!])")
           
                   print("\(totalData[svcTag!])")
                   
                   print("Updated")
                   }catch{
                      
                    print("Not Updated")
               }
              navigationController?.popViewController(animated: true)
                      
               
                  
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
