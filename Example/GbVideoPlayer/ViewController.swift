//
//  ViewController.swift
//  GbVideoPlayer
//
//  Created by 37006058 on 07/05/2022.
//  Copyright (c) 2022 37006058. All rights reserved.
//

import UIKit
import GbVideoPlayer


class ViewController: UIViewController {
    
    @IBOutlet weak var player: GbVideoPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.url = "https://livesportradio.com/global/livescore/playlist.m3u8"
        player.gbTitleOn = "Play audio commentary"
        player.gbTitleOff = "Stop audio commentary"
        player.gbTextColor = .white
        player.gbBackgroundColor = UIColor(red: 229/255, green: 70/255, blue: 68/255, alpha: 1)
        
        
    }

    
   

}

