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

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90.0;
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
}

class BlockCell: UITableViewCell
{
    var indexLabel = UILabel()
    var dataLabel = UILabel()
    var hashLabel = UILabel()
    
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
        
        indexLabel.frame = CGRect(x: 10, y: 5, width: self.frame.size.width-20, height: 10)
        indexLabel.font = UIFont.systemFont(ofSize: 10)
        //indexLabel.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(indexLabel)
        
        dataLabel.frame = CGRect(x: 10, y: 20, width: self.frame.size.width-20, height: 30)
        //dataLabel.backgroundColor = UIColor.gray
        self.contentView.addSubview(dataLabel)
        
        hashLabel.frame = CGRect(x: 10, y: 70, width: self.frame.size.width-20, height: 10)
        hashLabel.font = UIFont.systemFont(ofSize: 10)
        //hashLabel.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(hashLabel)
    }
    
    func layoutCellFromBlock(block:Block)
    {
        indexLabel.text = "BlockIndex # "+String(block.index)
        dataLabel.text = "BlockData: "+String(block.data)
        hashLabel.text = "hash "+String(block.blockHash)
    }
}
