//
//  Block.swift
//  SimpleChain
//
//  Created by Vincenzo Ajello on 13/11/17.
//  Copyright © 2017 Vincenzo Ajello. All rights reserved.
//

// This is a simple Block Class:
// every block have the following parmeters
// index : is an incremental integer that identify a block
// timestamp : store the timestamp of the creation date of the block
// data : store a custom data parameter
// previousHash : is the sha256 hash of the previous block
// blockHash : is the sha256 hash of the data about this block
// nonce : a incremental value used in the proof-of-work calculation

import UIKit

class Block: NSObject
{
    var index:Int
    var createdAt:Double
    var minedAt:Double = 0
    var miningTime:Double = 0
    var data:String
    var previousHash:String
    var blockHash:String = ""
    var nonce: Int = 0
    var difficult: Int
    
    // Constructor of the Block
    init(data:String, previousBlock:Block, difficult:Int)
    {
        self.index = previousBlock.index + 1
        self.createdAt = getCurrentTimestamp()
        self.data = data
        self.previousHash = previousBlock.blockHash
        self.difficult = difficult
    }
    
    // Constructor of the Genesis Block
    init(genesisBlockWithData:String)
    {
        self.index = 0
        self.createdAt = getCurrentTimestamp()
        self.data = genesisBlockWithData
        self.previousHash = "0"
        self.difficult = 0
        self.blockHash = hash_block_data(data:"\(self.index)\(self.createdAt)\(self.data)\(self.previousHash)\(self.nonce)")
    }
    
    func mine(completion: (_ mined:Block) -> Void)
    {
        self.blockHash = hashThisBlockData()
        var trial: String = getTrialSubstring(difficult: self.difficult, hash: self.blockHash)
        
        print("mining hash \(self.blockHash)")
        
        while trial != getTarget(difficult: self.difficult)
        {
            self.minedAt = getCurrentTimestamp()
            self.miningTime = Double(self.minedAt - self.createdAt) * 1000
            self.nonce = self.nonce + 1
            self.blockHash = hashThisBlockData()
            trial = getTrialSubstring(difficult: self.difficult, hash: self.blockHash)
            print("mining hash \(self.blockHash)")
        }
        completion(self)
    }
    
    func hashThisBlockData() -> String
    {
        return hash_block_data(data:"\(self.index)\(self.createdAt)\(self.data)\(self.previousHash)\(self.nonce)")
    }
}

func getTrialSubstring(difficult: Int, hash:String) -> String
{
    return String(hash[..<hash.index(hash.startIndex, offsetBy: difficult)])
}

func getTarget(difficult:Int) -> String
{
    return String(format: "%0\(difficult)ld")
}

// return a sha256 hash of a String
func hash_block_data(data:String) -> String
{
    return data.sha256()
}

//  Importing CommonCrypt is a pain the article above helped alot
//  link : https://stackoverflow.com/a/38788437

// Extending String Class to give hashing capabilities to it ;)
extension String
{
    func sha256() -> String
    {
        if let stringData = self.data(using: String.Encoding.utf8)
        {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData
    {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String
    {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes
        {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }
}

func getCurrentTimestamp() -> Double
{
    return NSDate().timeIntervalSince1970
}
