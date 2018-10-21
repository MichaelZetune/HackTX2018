//
//  createAccountViewController.swift
//  OneFamily
//
//  Created by Turner Gregory on 10/20/18.
//  Copyright © 2018 Turner. All rights reserved.
//

import UIKit

class createAccountViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        if passwordField.text != confirmField.text {
            //bad
        }
        
        //let url = URL(string: "https://onefamilycontainer.azurewebsites.net")
        
        //let parameters = ["email": email, "passwordHash": passwordField.text, "userType": "parent"] as [String : String]
        let parameters = ["email": "goodbye@gmail.com", "passwordHash": "myPassword", "userType": "parent"]
        //let parameters = "{\"email\":\"hello@gmail.com\",\"passwordHash\":\"myPassword\",\"userType\":\"parent\",\"UID\":\"abc\"}"
        
        let url = URL(string: "https://onefamilycontainer.azurewebsites.net/user/create")!
        
        var request = URLRequest(url: url)
        
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            print(response)
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
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
