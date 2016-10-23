//
//  TrailerViewController.swift
//  MovieApp
//
//  Created by Erica on 10/23/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit

class TrailerViewController: UIViewController {
    
    var youTubeVideoHTML: String = "<!DOCTYPE html><html><head><style>body{margin:0px 0px 0px 0px;}</style></head> <body> <div id=\"player\"></div> <script> var tag = document.createElement('script'); tag.src = \"http://www.youtube.com/player_api\"; var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubePlayerAPIReady() { player = new YT.Player('player', { width:'%0.0f', height:'%0.0f', videoId:'%@', events: { 'onReady': onPlayerReady, } }); } function onPlayerReady(event) { event.target.playVideo(); } </script> </body> </html>"
    
    var movieTrailer : Movie?
    
    let store = MovieDataStore.sharedStore
    
    @IBOutlet weak var trailerWebView: UIWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let movieID = movieTrailer?.movieID
        {
            self.store.api.movieTrailerAPIWithString(movieID, completion: { (stringID) in
                DispatchQueue.main.async { () -> Void in
                    
                    self.trailerWebView.mediaPlaybackRequiresUserAction = false
                    self.trailerWebView.allowsInlineMediaPlayback = true
                    
                    let html: String = String(format: self.youTubeVideoHTML, self.trailerWebView.frame.size.width, self.trailerWebView.frame.size.height, stringID)
                    
                    self.trailerWebView.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
                    
                }
            })
        }
    }
    
    
    
    
  }
