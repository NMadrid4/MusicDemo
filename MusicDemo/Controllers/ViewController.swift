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
    }
    @IBAction func pauseSong(_ sender: Any) {
        audioPlayer.pause()
        pauseButton.isHidden = true
        playButton.isHidden = false
    }
    


}

