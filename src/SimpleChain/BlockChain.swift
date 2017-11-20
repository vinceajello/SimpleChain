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
    var difficult:Int = 4;
    
    override init()
    {
        self.chain = []
    }
    
    // build Genesis Block as first block of the chain
    func createGenesisBlock()
    {
        let genesisBlock = Block.init(genesisBlockWithData: "HelloChain!")
        //let genesisBlock = Block(index: 0, data: "HelloChain!", previousBlock: Block.init(index: -1, data: "", previousBlock: nil))
        printBlockInfo(block: genesisBlock)
        self.chain.append(genesisBlock)
    }
    
    // fetch the last block in the chain and building a new block
    func addNewBlockWithData(data:String)
    {
        if chain.count == 0
        {
            print("Empty Chain! : Create a genesis block w HelloChain button")
            return
        }
        
        // fetch last block
        let lastBlock:Block = chain.last!
        
        // create the new block
        let newBlock = Block(data: data, previousBlock: lastBlock, difficult:self.difficult)
        
        // mine it
        newBlock.mine
        {
            (mined:Block) in
            printBlockInfo(block: newBlock)
            chain.append(newBlock)
        }
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
