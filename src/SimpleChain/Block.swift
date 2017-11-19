//
//  Block.swift
//  SimpleChain
//
//  Created by Vincenzo Ajello on 13/11/17.
//  Copyright © 2017 Vincenzo Ajello. All rights reserved.
//

// This is a simple Block Class:
// every block have the following parmeters
// blockIndex : is an incremental integer that identify a block
// blockTimestamp : store the timestamp of the creation date of the block
// blockData : store a custom data parameter
// blockPreviousHash : is the sha256 hash of the previous block
// blockHash : is the sha256 hash of the data about this block

import UIKit

class Block: NSObject
{
    var blockIndex:Int
    var blockTimestamp:UInt64
    var blockData:String
    var blockPreviousHash:String
    var blockHash:String
    
    init(index:Int, timestamp:UInt64, data:String, previous_hash:String)
    {
        self.blockIndex = index
        self.blockTimestamp = timestamp
        self.blockData = data
        self.blockPreviousHash = previous_hash
        self.blockHash = hash_block_data(data:"\(index)\(timestamp)\(data)\(previous_hash)")
    }
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

