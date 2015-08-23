//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Xavier Jorda Murria on 19/08/2015.
//
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet var recordingLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recordingLabel.hidden = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordButton(sender: UIButton)
    {
        println("in recordButton")
        recordingLabel.hidden = false
        
    }
}

