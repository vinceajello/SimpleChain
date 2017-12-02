//
//  BlocklistController.swift
//  SimpleChain
//
//  Created by Vincenzo Ajello on 14/11/17.
//  Copyright © 2017 Vincenzo Ajello. All rights reserved.
//

import UIKit

class BlocklistController: UITableViewController
{
    var blockchain:BlockChain = BlockChain()
    var progressView = ACProgressHUD.shared

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.darkGray
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140.0;
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return blockchain.chain.count
    }
    
    @IBAction func CloseButtonPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> BlockCell
     {
        let cell:BlockCell = tableView.dequeueReusableCell(withIdentifier: "BlockCell", for: indexPath) as! BlockCell
        cell.layoutCellFromBlock(block: blockchain.chain[indexPath.row])
        return cell
    }
    
    @IBAction func VerifyButtonPressed(_ sender: Any)
    {
        progressView.progressText = "Verifying blockchain..."
        progressView.showHUD()
        
        var previousBlock:Block
        var previousBlockHash:String
        
        for block in self.blockchain.chain.reversed()
        {
            // Check if the current block is the genesis block
            if block.index == 0
            {
                print("Genesis block has been reached")
                print("The chain appear to be valid")
                break
            }
            
            print("verifying if the block at index (\(block.index)) is valid")
            
            // Check if the hash if the block is valid for gthe current data and nonce
            if block.blockHash != block.hashThisBlockData()
            {
                print("invalid hash from the block at index(\(block.index))")
                break
            }

            // Check if the current block contain the right hash of the previous block
            previousBlock = blockchain.chain[block.index-1]
            previousBlockHash = previousBlock.blockHash
            if block.previousHash != previousBlockHash
            {
                print("the current block does not cantain the hash of the previous block")
                break
            }
        }
        
        self.perform(#selector(dismissLoader), with: nil, afterDelay: 1)
    }
    
    @objc func dismissLoader()
    {
        ACProgressHUD.shared.hideHUD()
    }
}

