//
//  ViewController.swift
//  MusicDemo
//
//  Created by Nicolas on 9/08/18.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import FirebaseAnalytics
import Firebase

class ViewController: UIViewController {
    
    var music: Music!
    var audioPlayer: AVPlayer!

    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        getSong()
        pauseButton.isHidden = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let screenClass = classForCoder.description()
        Analytics.setScreenName("Music ViewController", screenClass: screenClass)
    }
    
    func fillData() {
        let url = URL(string: music.image)
        let data = try? Data(contentsOf: url!)
        artistImageView.image = UIImage(data: data!)
        artistImageView.layer.cornerRadius = artistImageView.bounds.size.width / 2.0
        artistImageView.clipsToBounds = true
        
        titleLabel.text = music.title
        authorLabel.text = music.author
    }
    func getSong() {
        let audioSourceURL: URL!
        audioSourceURL = URL.init(string: music.song)

        if audioSourceURL == nil {
            print("Audio no compatible")
        }else {
                audioPlayer = AVPlayer.init(url: audioSourceURL!)

        }
    }
    
    @IBAction func playSong(_ sender: Any) {
        audioPlayer.play()
        playButton.isHidden = true
        pauseButton.isHidden = false
        
//        if let duration = audioPlayer.currentItem?.asset.duration {
//            let seconds = CMTimeGetSeconds(duration)
//            print(seconds)
//        }
//
//        
//        let duration: CMTime = self.audioPlayer.currentItem!.asset.duration;
//        let seconds = CMTimeGetSeconds(duration);
//        print(seconds)
//        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id play song",
            AnalyticsParameterContentType: "cont"
            ])
        
    }
    @IBAction func pauseSong(_ sender: Any) {
        audioPlayer.pause()
        pauseButton.isHidden = true
        playButton.isHidden = false
    }
    


}

