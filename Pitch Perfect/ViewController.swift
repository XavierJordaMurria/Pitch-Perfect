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

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onRecordButton(sender: UIButton)
    {
        println("in recordButton")
        setRecordingScreen(true)
    }
    @IBAction func onStopButton(sender: UIButton)
    {
        println("in recordButton")
        setRecordingScreen(false)
    }
    
    func setRecordingScreen(isRecording: Bool)
    {
        if(isRecording)
        {
            recordingLabel.hidden = false
            stopButton.hidden = false
        }
        else
        {
            recordingLabel.hidden = true
            stopButton.hidden = true
        }

    }
}

