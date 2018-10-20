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
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
