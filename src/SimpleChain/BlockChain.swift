//
//  BlockChain.swift
//  SimpleChain
//
//  Created by Vincenzo Ajello on 13/11/17.
//  Copyright © 2017 Vincenzo Ajello. All rights reserved.
//

import UIKit

class BlockChain: NSObject
{
    var chain:[Block]
    var difficult:Int = 2;
    var consoleOutputs: [String] = []
    
    override init()
    {
        self.chain = []
    }
    
    // build Genesis Block as first block of the chain
    func createGenesisBlock()
    {
        let genesisBlock = Block.init(genesisBlockWithData: "HelloChain!")
        addBlockInfoToConsole(block: genesisBlock)
        self.chain.append(genesisBlock)
    }
    
    // fetch the last block in the chain and building a new block
    func addNewBlockWithData(data:String)
    {
        // fetch last block
        let lastBlock:Block = chain.last!
        
        // create the new block
        let newBlock = Block(data: data, previousBlock: lastBlock, difficult:self.difficult)
        
        // mine it
        newBlock.mine
        {
            (mined:Block) in
            addBlockInfoToConsole(block: mined)
            
            chain.append(mined)
            ACProgressHUD.shared.hideHUD()
        }
    }
    
    // add block infos to consoleOutputs
    func addBlockInfoToConsole(block:Block)
    {
        printBlockInfo(block: block)
        
        consoleOutputs.append("")
        if block.index == 0
        {
            consoleOutputs.append("Genesis block:")
        }
        
        consoleOutputs.append("# BlockIndex(\(block.index) Timestamp: \(block.createdAt)")
        consoleOutputs.append("Blockdata \(block.data)")
        consoleOutputs.append("Created @ \(NSDate(timeIntervalSince1970: block.createdAt))")
        
        if block.index > 0
        {
            consoleOutputs.append("Mined @ \(NSDate(timeIntervalSince1970: block.minedAt))")
            consoleOutputs.append("MiningTime \(block.miningTime/1000)")
            consoleOutputs.append("CurrentDifficult \(block.difficult)")
            consoleOutputs.append("nonce \(block.nonce)")
        }

        consoleOutputs.append("Hash:\(block.blockHash)")
    }
    
    // Print block info for debug purpose
    func printBlockInfo(block:Block)
    {
        print("")
        if block.index == 0
        {print("Genesis block created!")}
        
        print("Block Info:")
        print("Index (\(block.index)) Timestamp: \(block.createdAt)")
        print("BlockData \(block.data)")
        print("CreatedAt \(NSDate(timeIntervalSince1970: block.createdAt))")
        print("MinedAt \(NSDate(timeIntervalSince1970: block.minedAt ))")
        print("MiningTime \(block.miningTime/1000)")
        print("Difficult \(block.difficult)")
        print("BlockHash \(block.blockHash)")
        print("nonce \(block.nonce)")
    }
}
