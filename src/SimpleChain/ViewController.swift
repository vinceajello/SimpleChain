//
//  ViewController.swift
//  SimpleChain
//
//  Created by Vincenzo Ajello on 13/11/17.
//  Copyright © 2017 Vincenzo Ajello. All rights reserved.
//
//
//  The following code is a translation of the python code founded on the article linked below
//  link : https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
//
//  Importing CommonCrypt is a pain the article below helped alot
//  link : https://stackoverflow.com/a/38788437
//
//
//  
//
//  This Controller is the entry point of the app
//

import UIKit

class ViewController: UIViewController
{
    var blockchain = BlockChain()
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var HelloChainButton: UIButton!
    @IBOutlet weak var AddNewBlockButton: UIButton!
    var progressView = ACProgressHUD.shared

    override func viewDidLoad()
    {
        super.viewDidLoad()
        field.textColor = UIColor.darkGray
        AddNewBlockButton.tintColor = UIColor.darkGray
        self.progressView = ACProgressHUD.shared
    }
    
    @IBAction func HelloChainButtonPressed(_ sender: Any)
    {
        if self.blockchain.chain.count > 0
        {
            self.showErrorInsideField(field: self.field, error: "genesis block is already here")
            return
        }
        blockchain.createGenesisBlock()
    }
    
    @IBAction func AddNewBlockButtonPressed(_ sender: Any)
    {
        if self.blockchain.chain.count == 0
        {
            self.showErrorInsideField(field: self.field, error: "create a genesis block first")
            return
        }
        
        if field.text == ""
        {
            self.showErrorInsideField(field: self.field, error: "please type something in the field")
            return
        }
        
        self.field.resignFirstResponder()
        
        progressView.progressText = "mining next block..."
        progressView.showHUD()
        
        let data = self.field.text
        DispatchQueue.global(qos: .background).async
        {
            self.blockchain.addNewBlockWithData(data: data!)
        }
        
        field.text = ""
    }
    
    func showErrorInsideField(field:UITextField,error:String)
    {
        field.textColor = UIColor.red
        field.text = error
        field.textAlignment = NSTextAlignment.center
        self.perform(#selector(resetErrorField), with: field, afterDelay: 1)
    }
    
    @objc func resetErrorField(field:UITextField)
    {
        field.textColor = UIColor.darkGray
        field.textAlignment = NSTextAlignment.left
        field.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is BlocklistController
        {
            let vc = segue.destination as? BlocklistController
            vc?.blockchain = self.blockchain
        }
        if segue.destination is ConsoleController
        {
            let vc = segue.destination as? ConsoleController
            vc?.outputs = self.blockchain.consoleOutputs
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

