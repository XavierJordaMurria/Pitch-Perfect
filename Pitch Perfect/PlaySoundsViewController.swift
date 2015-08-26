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
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if var filePathString = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        {
            var alertSoundURL = NSURL.fileURLWithPath(filePathString)
            println("playSlowAudio will try to play audio located in: \(alertSoundURL)")
            
            var error:NSError?
            audioPlayer = AVAudioPlayer(contentsOfURL: alertSoundURL, error: &error)
            audioPlayer.enableRate = true
        }
        else
        {
            println("AudioFIle empty")
        }

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        playAudioCustomSpeed(2.0)
    }
    
    @IBAction func playSlowAudio(sender: AnyObject)
    {
        playAudioCustomSpeed(0.3)
    }


    @IBAction func onStopAudio(sender: AnyObject)
    {
        audioPlayer.stop()
    }
    
    // MARK: - Internal Methods
    
    func playAudioCustomSpeed(speed: Float)
    {
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}

