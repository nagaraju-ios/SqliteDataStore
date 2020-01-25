//
//  ViewController.swift
//  SqliteDataStore
//
//  Created by THOTA NAGARAJU on 12/18/19.
//  Copyright © 2019 THOTA NAGARAJU. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
  // Create Varabels
    
    var path:String!
    var dconect:Connection!
    var buttonArray1 = [UIButton]()
    var buttonArray2 = [UIButton]()
    var buttonArray3 = [UIButton]()
    var btnTag:Int!
    static var  butonTap:String!
    var values = [Int64]()
    var text = String()
    static var FirstName = [String]()
    static var LastName = [String]()
    static var Qualify = [String]()
    
  // Create ib outlet varabels
    
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var stackView3: UIStackView!
    override func viewDidLoad() {
        
        pathFun()
        super.viewDidLoad()
        
       
       }

// Create a PathFunction
    func pathFun(){
         path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
               do{
                   print (path!)

                
              dconect = try
               Connection("\(path!)/naga.sqlite3")
                   try! dconect.run("CREATE TABlE IF NOT EXISTS CONTACTS( ID INTEGER PRIMARY KEY AUTOINCREMENT, FIRSTNAME,LASTNAME,QUALIFICATION)")
                   
               }catch{
                   
                   print("something went wrong")
                   
               }
        
    }
    
 // ADD Contacts fun usin for loop condthions with buttons
    
    @IBAction func AddBtn(_ sender: Any) {
        
        ViewController.butonTap == "a"
        
       for  y in buttonArray1{
            y.removeFromSuperview()
            }
       for  x in buttonArray2{
            x.removeFromSuperview()
            }
       for  z in buttonArray3{
            z.removeFromSuperview()
            }
        buttonArray1 = [UIButton]()
        buttonArray2 = [UIButton]()
        buttonArray3 = [UIButton]()
        
        let svc = self.storyboard?.instantiateViewController(withIdentifier: "SVC") as! SCViewController
        navigationController?.pushViewController(svc, animated: true)
        
        
    }
    
    
    
  // ViewWiilAppear function
    
    override func viewWillAppear(_ animated: Bool) {
           for  x in buttonArray1{
                x.removeFromSuperview()
                }
           for  y in buttonArray2{
                y.removeFromSuperview()
                }
           for  z in buttonArray3{
                z.removeFromSuperview()
                }
            
        
            buttonArray1 = [UIButton]()
            buttonArray2 = [UIButton]()
            buttonArray3 = [UIButton]()
        
            
             stackView.spacing =  30
             stackView2.spacing = 30
             stackView3.spacing = 30
             values = [Int64]()
         do{
        let  statmnt = try! dconect.run(" SELECT * FROM CONTACTS")
            
            for (t,row) in statmnt.enumerated(){
               
                
                 for (index ,name ) in
                     statmnt.columnNames.enumerated(){
                         
                        if (name == "ID"){
                            values.append(row[index] as!Int64)
                            
            }
                else if(name == "FIRSTNAME"){
                ViewController.FirstName.append(row[index]as! String)
                text = row[index] as! String
                            
                }else if(name == "LASTNAME"){
                ViewController.LastName.append(row[index] as! String)
                text += " " + (row[index]! as! String)
                            
                }else if(name == "QUALIFICATION"){
                    ViewController.Qualify.append(row[index] as! String)
                    text += "\n" + (row[index]! as! String)
                        }
                      
                 }
                let retriveBtn = UIButton()
                retriveBtn.backgroundColor = UIColor.cyan
                retriveBtn.tag = t
                retriveBtn.setTitle(text, for: UIControl.State.normal)
                retriveBtn.backgroundColor = .blue
                buttonArray1.append(retriveBtn)
                retriveBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                retriveBtn.titleLabel?.numberOfLines = 0
                stackView.addArrangedSubview(retriveBtn)
                
               print(text)
                let deltBtn = UIButton()
                deltBtn.tag = t
                deltBtn.backgroundColor = .red
                deltBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                deltBtn.setBackgroundImage(UIImage(named: "delete"), for: UIControl.State.normal)
                deltBtn.titleLabel?.numberOfLines = 0
                deltBtn.addTarget(self, action:#selector(buttonTarget2(obj:)), for: UIControl.Event.touchUpInside)
                buttonArray2.append(deltBtn)
                stackView2.addArrangedSubview(deltBtn)
                

               let updateBtn = UIButton()
                updateBtn.tag = t
                updateBtn.backgroundColor = .red
                updateBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                updateBtn.setBackgroundImage(UIImage(named: "create"), for: UIControl.State.normal)
                updateBtn.titleLabel?.numberOfLines = 0
  updateBtn.addTarget(self,action:#selector(buttonTarget3(obj:)), for: UIControl.Event.touchUpInside)
                 buttonArray3.append(updateBtn)
                stackView3.addArrangedSubview(updateBtn)
                
           

             }
            print("adding")
             
         }catch{
             print("Not Display")
         }

    }
    
    
  // Addtargets to The DELETE button
    
    @objc func buttonTarget2(obj:UIButton){
       
  btnTag = obj.tag
        
        do {
            let statment2 = try! dconect.run("DELETE FROM CONTACTS WHERE ID = \(values[btnTag!])")
            print("\(values[btnTag!])")
            print("deleted")
        }catch{
            
            print("Not Deleted")
        }
        
    }
    
 // Addtargets to The UPDATE button
    @objc func buttonTarget3(obj:UIButton){
        
         ViewController.butonTap == "b"

          let svc = self.storyboard?.instantiateViewController(withIdentifier: "SVC") as! SCViewController
        svc.svcTag = obj.tag
        svc.totalData = values
        svc.qualify = text
        navigationController?.pushViewController(svc, animated: true)

       }
    
}

