//
//  parentDashViewController.swift
//  OneFamily
//
//  Created by Turner Gregory on 10/20/18.
//  Copyright © 2018 Turner. All rights reserved.
//

import UIKit

class parentDashViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //var accounts: [Account]?
    var accounts: [Account] = []
    var selectedAccount: Account?
    
    @IBOutlet weak var collection: UICollectionView!
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        //let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: 340, height: 100)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        collection?.collectionViewLayout = layout
        
        //preloading stuff cuz this is a hackathon
        
        var names: [String] = ["Turner", "Yashasvi", "Chris", "Peter", "Michael"]
        var balances: [String] = ["$473.18", "$596.15", "$472.18", "$2.50", "$1009.08"]
        
        var i = 0
        while i < names.count {
            let account = Account()
            account.name = names[i]
            account.balance = balances[i]
            accounts.append(account)
            i = i + 1
        }
        
        //collection.backgroundColor = UIColor.cyan
        //self.view.backgroundColor = UIColor.cyan
        
        collection.reloadData()
    }
    
    //MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountCell", for: indexPath) as! parentAccountsCollectionViewCell
        
        let account = accounts[indexPath.row]
        
        cell.backgroundColor = UIColor.blue
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = cell.bounds
        cell.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.nameLabel.text = account.name
        cell.nameLabel.textColor = UIColor.white
        cell.balanceLabel.text = account.balance
        cell.balanceLabel.textColor = UIColor.white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAccount = accounts[indexPath.row]
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
