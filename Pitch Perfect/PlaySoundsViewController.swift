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
    var audioPlayer2: AVAudioPlayer!
    var audioPlayer3: AVAudioPlayer!
    
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
        
        audioPlayer2 = AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl, error: &error)
        audioPlayer2.enableRate = true
        
        audioPlayer3 = AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl, error: &error)
        audioPlayer3.enableRate = true
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
        stopPlayingAudio()
    }
    
    @IBAction func onPlayChipmunkAudio(sender: AnyObject)
    {
        println("onPlayChipmunkAudio")
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func onPlayChipmunkVader(sender: AnyObject)
    {
        println("onPlayChipmunkVader")
        playAudioEcho()
    }

    @IBAction func dragInside(sender: AnyObject)
    {
      playAudioReverb(70.0)
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
        stopPlayingAudio()
        
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    /**
    * Prepare the AVAudioPlayer to play audio at a custom speed (speed)
    */
    func playAudioWithVariablePitch(pitch: Float)
    {
        stopPlayingAudio()
        
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

    func playAudioReverb(reverb: Float)
    {
        stopPlayingAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var reverbEffect = AVAudioUnitReverb()
        
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbEffect.wetDryMix = reverb
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func playAudioEcho()
    {
        stopPlayingAudio()
        
        audioPlayer.currentTime = 0;
        audioPlayer.play()
        
        let delay:NSTimeInterval = 0.3//100ms
        var playtime:NSTimeInterval
       
        playtime = audioPlayer2.deviceCurrentTime + delay
        
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.8;
        
        audioPlayer2.playAtTime(playtime)
        
        let delay2:NSTimeInterval = 0.3//100ms
        
        var playtime2:NSTimeInterval
        playtime2 = audioPlayer2.deviceCurrentTime + delay2
        
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.8;
        
        audioPlayer2.playAtTime(playtime2)
    }
    
    func stopPlayingAudio()
    {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
}

