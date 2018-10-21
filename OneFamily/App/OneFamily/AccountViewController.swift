//
//  AccountViewController.swift
//  OneFamily
//
//  Created by Turner Gregory on 10/20/18.
//  Copyright © 2018 Turner. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var account: Account?
    var transactions: [Transaction] = []
    var request: String?
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func request(_ sender: UIBarButtonItem) {
        showInputDialog()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false;
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.black.cgColor
        
        addTransaction(x: 0)
        
        self.title = account?.name
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    /*
    func clearTable() {
        account?.transactions = nil
        let indexPath = IndexPath(item: 0, section: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
    }
    */
    func addTransaction(x: Int) {
        
        //account?.transactions = nil
        
        var descriptions: [String] = ["Microsoft Store", "Capital One Withdrawal",
                                      "AT&T Conference Center Valet", "Kerbey Lane Cafe",
                                      "Southwest Airlines Flight", "Erik's Tacos"]
        var amounts: [String] = ["-$98.65", "-$100.00", "-$20.00", "-$19.37", "-$301.42", "$14.63"]
        var dates: [String] = ["10/21/2018", "10/21/2018", "10/21/2018", "10/20/2018", "10/19/2018", "10/18/2018"]
        
        if x == 1 {
            descriptions = ["Account Deposit", "Microsoft Store", "Capital One Withdrawal",
                                          "AT&T Conference Center Valet", "Kerbey Lane Cafe",
                                          "Southwest Airlines Flight", "Erik's Tacos"]
            amounts = ["+$50.00", "-$98.65", "-$100.00", "-$20.00", "-$19.37", "-$301.42", "$14.63"]
            dates = ["10/21/2018", "10/21/2018", "10/21/2018", "10/21/2018", "10/20/2018", "10/19/2018", "10/18/2018"]
        }
        
        
        
        var i = 0
        while i < descriptions.count {
            let transaction = Transaction()
            transaction.description = descriptions[i]
            transaction.date = dates[i]
            transaction.amount = amounts[i]
            transactions.append(transaction)
            i = i + 1
        }
        
        account?.transactions = transactions
        
        tableView.reloadData()
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Request Funds", message: "Enter an Amount", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            //getting the input values from user
            self.request = (alertController.textFields?[0].text)!
            
            self.balanceLabel.text = "$646.15"
            
            //self.addTransaction(x: 1)
            
            
            //self.performSegue(withIdentifier: "addList", sender: nil)
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "$0.00"
            textField.autocapitalizationType = UITextAutocapitalizationType.sentences
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return account?.transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "transactionCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? transactionTableViewCell else {
            fatalError("The dequeued cell is not an instance of playlistTableViewCell.")
        }
        
        // Fetches the appropriate item for the data source layout.
        let transaction = account?.transactions?[indexPath.row]
        
        cell.descriptionLabel.text = transaction?.description
        cell.dateLabel.text = transaction?.date
        cell.amountLabel.text = transaction?.amount
        /*
        if(transaction?.amount == "+$50.00") {
            cell.amountLabel.textColor = UIColor.green
        } else {
            cell.amountLabel.textColor = UIColor.red
        }
        */
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        //print ("Swiped Left")
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizer.Direction.left:
                
                
                //change view controllers
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "chartsViewController") as! chartsViewController
                
                let transition = CATransition()
                transition.duration = 0.25
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                self.view.window!.layer.add(transition, forKey: kCATransition)
                present(resultViewController, animated: false)
                
            default:
                break
            }
        }
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
