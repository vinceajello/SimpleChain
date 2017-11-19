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
    
    override init()
    {
        self.chain = []
    }
    
    // build Genesis Block as first block of the chain
    func createGenesisBlock()
    {
        let genesisBlock = Block(index: 0, timestamp: Date().timestamp, data: "HelloChain!", previous_hash: "N0N3")
        printBlockInfo(b: genesisBlock)
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
        
        let lastBlock:Block = chain.last!
        let newBlock = buildNextBlockWithData(previousBlock: lastBlock, data: data)
        printBlockInfo(b: newBlock)
        chain.append(newBlock)
    }
    
    // building a new block
    // ToDo: implement proof of work
    func buildNextBlockWithData(previousBlock:Block, data:String) ->Block
    {
        let nextIndex = self.chain.count
        let blockTimestamp = Date().timestamp
        let blockData = data
        let blockHash = previousBlock.blockHash
        return Block(index: nextIndex, timestamp: blockTimestamp, data: blockData, previous_hash: blockHash)
    }
    
    // Print block info for debug purpose
    func printBlockInfo(b:Block)
    {
        if b.blockIndex == 0
        {print("Genesis block created!")}
        
        print("Block Info:")
        print("Index (\(b.blockIndex)) Timestamp: \(b.blockTimestamp)")
        print("BlockData \(b.blockData)")
        print("BlockHash \(b.blockHash)")
    }
}

// extend the Date Class to support timestamp
extension Date
{
    var timestamp: UInt64
    {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}
