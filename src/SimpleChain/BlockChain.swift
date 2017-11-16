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
    
    func createGenesisBlock()
    {
        let genesisBlock = Block(index: 0, timestamp: Date().timestamp, data: "HelloChain!", previous_hash: "N0N3")
        print("Genesis block created!")
        printBlockInfo(b: genesisBlock)
        self.chain.append(genesisBlock)
    }
    
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
    
    func buildNextBlockWithData(previousBlock:Block, data:String) ->Block
    {
        let nextIndex = self.chain.count
        let blockTimestamp = Date().timestamp
        let blockData = data
        let blockHash = previousBlock.blockHash
        return Block(index: nextIndex, timestamp: blockTimestamp, data: blockData, previous_hash: blockHash)
    }
    
    func printBlockInfo(b:Block)
    {
        print("Block Info:")
        print("Index (\(b.blockIndex)) Timestamp: \(b.blockTimestamp)")
        print("BlockData \(b.blockData)")
        print("BlockHash \(b.blockHash)")
    }
}

extension Date
{
    var timestamp: UInt64
    {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}
