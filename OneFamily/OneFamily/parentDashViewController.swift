//
//  parentDashViewController.swift
//  OneFamily
//
//  Created by Turner Gregory on 10/20/18.
//  Copyright © 2018 Turner. All rights reserved.
//

import UIKit

class parentDashViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var numAccounts = 3
    var accounts: [Account]?
    var selectedAccount: Account?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Table View methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numAccounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "cell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? parentAccountTableViewCell else {
            fatalError("The dequeued cell is not an instance of playlistTableViewCell.")
        }
        
        // Fetches the appropriate item for the data source layout.
        let account = accounts?[indexPath.row]
        
        cell.nameLabel.text = account?.name
        cell.balanceLabel.text = account?.balance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAccount = accounts?[indexPath.row]
        performSegue(withIdentifier: "parentViewAccount", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "parentViewAccount" {
            let dest = segue.destination as! AccountViewController
            dest.account = selectedAccount!
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
