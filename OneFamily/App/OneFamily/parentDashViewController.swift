//
//  parentDashViewController.swift
//  OneFamily
//
//  Created by Turner Gregory on 10/20/18.
//  Copyright © 2018 Turner. All rights reserved.
//

import UIKit

class parentDashViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var accounts: [Account]?
    var selectedAccount: Account?
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        //preloading stuff cuz this is a hackathon
        let account1 = Account()
        account1.name = "Turner"
        account1.balance = "3.50"
        
        let account2 = Account()
        account2.name = "Chris"
        account2.balance = "5.00"
        
        let account3 = Account()
        account3.name = "Yashasvi"
        account3.balance = "1000.00"
        
        accounts = [account1, account2, account3]
        
        collection.reloadData()
    }
    
    //MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountCell", for: indexPath) as! parentAccountsCollectionViewCell
        
        let account = accounts?[indexPath.row]
        
        cell.backgroundColor = UIColor.blue

        cell.nameLabel.text = account?.name
        cell.balanceLabel.text = account?.balance
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAccount = accounts?[indexPath.row]
        performSegue(withIdentifier: "parentViewAccount", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "parentViewAccount" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! AccountViewController
            targetController.account = selectedAccount!
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
