//
//  LongPlotViewController.swift
//  MovieApp
//
//  Created by Erica on 9/11/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LongPlotViewController: UIViewController {
    
    @IBOutlet weak var fullActivityIndicator: UIActivityIndicatorView!
    var movie: Movie?
    var movieId:String!
   
    let store = MovieDataStore.sharedStore
    
    @IBOutlet weak var longPlotSummaryTextField: UITextView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
        

      //  print(movieId)
        
       self.title = "Full Plot"
        
        self.fullActivityIndicator.isHidden = false
        self.fullActivityIndicator.startAnimating()
        
        view.backgroundColor = UIColor.darkGray
       longPlotSummaryTextField.backgroundColor = UIColor.darkGray
    
        
        self.store.getLongSummaryPlot((movieId)!) { (longPlot) in
          
            
            
            DispatchQueue.main.async(execute: {
                
                self.longPlotSummaryTextField.text = longPlot
                self.fullActivityIndicator.isHidden = true
                self.fullActivityIndicator.stopAnimating()
                
            })
            
            
            
        }

        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
  
    

}
