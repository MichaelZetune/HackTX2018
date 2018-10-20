//
//  AccountViewController.swift
//  OneFamily
//
//  Created by Turner Gregory on 10/20/18.
//  Copyright © 2018 Turner. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var accountNameLabel: UILabel!
    
    var account: Account?
    var request: String?
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func request(_ sender: UIBarButtonItem) {
        showInputDialog()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        accountNameLabel.text = account?.name
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Request Funds", message: "Enter an Amount", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            //getting the input values from user
            self.request = (alertController.textFields?[0].text)!
            
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
        
        return cell
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
