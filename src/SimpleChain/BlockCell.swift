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
        
        indexLabel.frame = CGRect(x: 10, y: 10, width: self.frame.size.width-20, height: 10)
        indexLabel.font = UIFont.systemFont(ofSize: 10)
        //indexLabel.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(indexLabel)
        
        dataLabel.frame = CGRect(x: 10, y: 25, width: self.frame.size.width-20, height: 30)
        dataLabel.backgroundColor = UIColor.lightGray
        dataLabel.layer.cornerRadius = 4
        dataLabel.clipsToBounds = true
        dataLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(dataLabel)
        
        hashLabel.frame = CGRect(x: 10, y: 60, width: self.frame.size.width-20, height: 40)
        hashLabel.font = UIFont.systemFont(ofSize: 10)
        hashLabel.numberOfLines = 0
        self.contentView.addSubview(hashLabel)
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
        }
        
        dataLabel.text = "data: "+String(block.data)
        hashLabel.text = "hash: "+String(block.blockHash)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
