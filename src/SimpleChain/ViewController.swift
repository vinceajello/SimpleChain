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
//
//

import UIKit

class ViewController: UIViewController
{
    var blockchain = BlockChain()
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var HelloChainButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func HelloChainButtonPressed(_ sender: Any)
    {
        blockchain.createGenesisBlock()
        HelloChainButton.isEnabled = false
    }
    
    @IBAction func AddNewBlockButtonPressed(_ sender: Any)
    {
        if field.text == ""
        {
            print("NoData : Type something in the field")
            return
        }
        blockchain.addNewBlockWithData(data: field.text!)
        field.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is BlocklistController
        {
            let vc = segue.destination as? BlocklistController
            vc?.blockchain = self.blockchain
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

