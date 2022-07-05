//
//  GbVideoPlayer.swift
//  GbVideoPlayer
//
//  Created by admin on 5/07/22.
//

import UIKit
import AVKit

@IBDesignable
public class GbVideoPlayerView: UIView {

    private var player : AVPlayer!
    private var isPlaying = true
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate var label : UILabel!
    fileprivate var imageView : UIImageView!
    
    public override func draw(_ rect: CGRect){
        super.draw(rect)
        
        let viewWidth : CGFloat = 260
        let viewHeight : CGFloat = 50
        
        let view = UIView(frame: CGRect(x: frame.width/2 - viewWidth/2, y: frame.height/2 - viewHeight/2, width: viewWidth, height: viewHeight))
        view.backgroundColor = UIColor(red: 229/255, green: 70/255, blue: 68/255, alpha: 1)
        view.layer.cornerRadius = 12
        
        imageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
        let image = UIImage(named: "ic_pause", in: Bundle(for: type(of: self)), compatibleWith: .none)
        if let image = image {
            imageView.image = image
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
       
        
        label = UILabel(frame: CGRect(x: 55, y: 10, width: 190, height: 30))
        label.text = "Stop audio commentary"
        label.textColor = .white
        
        view.addSubview(label)
        view.addSubview(imageView)
        addSubview(view)
        initPlayer()
    }
    
    
    fileprivate func initPlayer(){
        let url = "https://livesportradio.com/global/livescore/playlist.m3u8"
        let asset = AVAsset(url: URL(string: url)!)
        let playerItem = AVPlayerItem(asset: asset)
        
        player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        player.addObserver(self, forKeyPath: "status", options: [], context: nil)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        isPlaying.toggle()
        if isPlaying{
            player.play()
            label.text = "Stop audio commentary"
            let image = UIImage(named: "ic_pause", in: Bundle(for: type(of: self)), compatibleWith: .none)
            if let image = image {
                imageView.image = image
            }
        }else{
            player.pause()
            label.text = "Play audio commentary"
            let image = UIImage(named: "ic_play", in: Bundle(for: type(of: self)), compatibleWith: .none)
            if let image = image {
                imageView.image = image
            }
        }
    }
    
   
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if let player = object as? AVPlayer, player == player, keyPath == "status" {
               if player.status == .readyToPlay {
                   player.play()
               } else if player.status == .failed {
                   player.pause()
               }
           }
       }
   
    

}
