//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Xavier Jorda Murria on 19/08/2015.
//
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate
{

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
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
    
    override func viewWillAppear(animated: Bool)
    {
        recordButton.enabled = true
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        setRecordingScreen(false)
    }

    // MARK: - IBActions

    @IBAction func onRecordButton(sender: UIButton)
    {
        println("Record Button Pressed")

        setRecordingScreen(true)
        startRecording()
    }
    @IBAction func onStopButton(sender: UIButton)
    {
        println("stop Button Pressed")
        setRecordingScreen(false)
        audioRecorder.stop()
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    // MARK: - AVAudioRecorderDelegate methods
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        
    }
    
    // MARK: - Internal Methods
    
    func setRecordingScreen(isRecording: Bool)
    {
        if(isRecording)
        {
            recordingLabel.hidden = false
            stopButton.hidden = false
            
            //disable the record button as it is already recording
            recordButton.enabled = false
            
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
            
            //enable the recording butto in case the user wants to record again.
            recordButton.enabled = true
            
            //setting the recodring Button to the Defauls state
            recordButton.imageView!.stopAnimating()
            var micBlue:UIImage = UIImage(named: "MicrophoneVectorPDF")!
            recordButton.setImage(micBlue, forState: UIControlState.Normal)
        }

    }
    
    func startRecording()
    {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        //let currentDateTime = NSDate()
        //let formatter = NSDateFormatter()
        //formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        //let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        
        let recordingName = "my_audio.wav"
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
}

