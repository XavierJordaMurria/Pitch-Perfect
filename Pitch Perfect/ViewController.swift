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
    @IBOutlet weak var recordButton: UIButton!
    
    var recordingButtonArrayAnimation = [UIImageView]()
    
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
        println("Record Button Pressed")
        setRecordingScreen(true)
    }
    @IBAction func onStopButton(sender: UIButton)
    {
        println("stop Button Pressed")
        setRecordingScreen(false)
    }
    
    func setRecordingScreen(isRecording: Bool)
    {
        if(isRecording)
        {
            recordingLabel.hidden = false
            stopButton.hidden = false
            
            //setting the recodring animation
            var micRed:UIImage = UIImage(named: "MicrophoneVectorRed")!
            var micRedBottomHalf:UIImage = UIImage(named: "MicrophoneVectorRedHalf")!
            recordButton.setImage(micRed, forState: UIControlState.Normal)
            recordButton.imageView!.animationImages = [micRed, micRedBottomHalf]
            recordButton.imageView!.animationDuration = 0.8
            recordButton.imageView!.startAnimating()
        }
        else
        {
            recordingLabel.hidden = true
            stopButton.hidden = true
            
            //setting the recodring Button to the Defauls state
            recordButton.imageView!.stopAnimating()
            var micBlue:UIImage = UIImage(named: "MicrophoneVectorPDF")!
            recordButton.setImage(micBlue, forState: UIControlState.Normal)
        }

    }
}

