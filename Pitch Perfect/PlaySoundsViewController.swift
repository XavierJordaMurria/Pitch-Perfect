//
//  PlaySoundsViewController
//  Pitch Perfect
//
//  Created by Xavier Jorda Murria on 19/08/2015.
//
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController
{
    var audioPlayer: AVAudioPlayer!
    var recordedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        audioEngine = AVAudioEngine()
        
        audioFile = AVAudioFile(forReading: recordedAudio.filePathUrl, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl, error: &error)
        audioPlayer.enableRate = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool)
    {
    }
    
    override func viewDidDisappear(animated: Bool)
    {
    }
    
    // MARK: - IBActions
    
    @IBAction func playFastAudio(sender: AnyObject)
    {
        println("playFastAudio")
        playAudioCustomSpeed(2.0)
    }
    
    @IBAction func playSlowAudio(sender: AnyObject)
    {
        println("playSlowAudio")
        playAudioCustomSpeed(0.3)
    }

    @IBAction func onStopAudio(sender: AnyObject)
    {
        println("onStopAudio")
        audioPlayer.stop()
    }
    
    @IBAction func onPlayChipmunkAudio(sender: AnyObject)
    {
        println("onPlayChipmunkAudio")
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func onPlayDarthVaderAudio(sender: AnyObject)
    {
        println("onPlayDarthVaderAudio")
        playAudioWithVariablePitch(-1000)
    }
    // MARK: - Internal Methods
    
    /**
    * Prepare the AVAudioPlayer to play audio at a custom speed (speed)
    */
    func playAudioCustomSpeed(speed: Float)
    {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    /**
    * Prepare the AVAudioPlayer to play audio at a custom speed (speed)
    */
    func playAudioWithVariablePitch(pitch: Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}

