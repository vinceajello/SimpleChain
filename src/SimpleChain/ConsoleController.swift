//
//  ConsoleController.swift
//  SimpleChain
//
//  Created by Vincenzo Ajello on 21/11/17.
//  Copyright © 2017 Vincenzo Ajello. All rights reserved.
//

import UIKit

class ConsoleController: UIViewController
{
    var outputs: [String] = []
    @IBOutlet weak var outputView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for output in outputs
        {
            self.outputView.text.append("\n")
            self.outputView.text.append(output)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
