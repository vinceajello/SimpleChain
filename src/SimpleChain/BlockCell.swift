//
//  BlockCell.swift
//  SimpleChain
//
//  Created by Vincenzo Ajello on 21/11/17.
//  Copyright © 2017 Vincenzo Ajello. All rights reserved.
//

import UIKit

class BlockCell: UITableViewCell
{
    var indexLabel = UILabel()
    var dataLabel = UILabel()
    var hashLabel = UILabel()
    var upChain = UIView()
    var downChain = UIView()
    var upChainX: CGFloat = 0.0
    var downChainX:CGFloat = 40.0
    
    override func awakeFromNib(){super.awakeFromNib()}
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, block:Block)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.clear
        
        let wrapper = UIView.init(frame: CGRect.init(x: 10, y: 10, width: self.frame.size.width-20, height: self.frame.size.height-20))
        wrapper.backgroundColor = UIColor.white
        wrapper.layer.cornerRadius = 4
        wrapper.clipsToBounds = true
        self.addSubview(wrapper)
        
        indexLabel.frame = CGRect(x: 10, y: 15, width: wrapper.frame.size.width-20, height: 10)
        indexLabel.font = UIFont.systemFont(ofSize: 11)
        //indexLabel.backgroundColor = UIColor.lightGray
        wrapper.addSubview(indexLabel)
        
        dataLabel.frame = CGRect(x: 10, y: 30, width: wrapper.frame.size.width-20, height: 30)
        //dataLabel.layer.cornerRadius = 4
        //dataLabel.clipsToBounds = true
        //dataLabel.textAlignment = NSTextAlignment.center
        dataLabel.textColor = UIColor.darkText
        wrapper.addSubview(dataLabel)
        
        hashLabel.frame = CGRect(x: 10, y: 62, width: wrapper.frame.size.width-20, height: 40)
        hashLabel.font = UIFont.systemFont(ofSize: 10)
        hashLabel.numberOfLines = 0
        wrapper.addSubview(hashLabel)
 
        self.bringSubview(toFront: upChain)
        self.bringSubview(toFront: downChain)
    }
    
    func layoutCellFromBlock(block:Block)
    {
        if block.index == 0
        {
            indexLabel.text = "Genesis Block (0)"
        }
        else
        {
            indexLabel.text = "BlockIndex # "+String(block.index)
            
            if block.index % 2 == 0
            {
                upChainX = self.frame.size.width - 40 - upChain.frame.size.width
                downChainX = 40
            }
            else
            {
                upChainX = 40
                downChainX = self.frame.size.width - 40 - downChain.frame.size.width
            }
            
            upChain = UIView.init(frame: CGRect.init(x: upChainX, y: -5, width: 5, height: 25))
            upChain.backgroundColor = UIColor(red:0.01, green:0.58, blue:0.58, alpha:1.0)
            upChain.layer.cornerRadius = upChain.frame.size.width / 2
            upChain.clipsToBounds = true
            self.addSubview(upChain)
        }
        
        downChain = UIView.init(frame: CGRect.init(x: downChainX, y: self.frame.size.height-20, width: 5, height: 25))
        downChain.backgroundColor = UIColor(red:0.01, green:0.58, blue:0.58, alpha:1.0)
        downChain.layer.cornerRadius = downChain.frame.size.width / 2
        downChain.clipsToBounds = true
        self.addSubview(downChain)
        
        dataLabel.text = "data: "+String(block.data)
        hashLabel.text = "hash: "+String(block.blockHash)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
