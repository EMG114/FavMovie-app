//
//  LongPlotViewController.swift
//  MovieApp
//
//  Created by Erica on 9/11/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation
import UIKit

class LongPlotViewController: UIViewController {
    
    var movie: Movie?
    var movieId:String!
   
    let store = MovieDataStore.sharedStore
    
    @IBOutlet weak var longPlotSummaryTextField: UITextView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("loading long plot view controller")
        

        print(movieId)
        
       self.title = "Full Plot"
        
         view.backgroundColor = UIColor.darkGrayColor()
//        longPlotSummaryTextField.backgroundColor = UIColor.darkGrayColor()
    
        
        self.store.getLongSummaryPlot(movieId) { (longPlot) in
           // print("THIS IS THE LONG PLOT CONTROLLER \(longPlot)")
            
            
            dispatch_async(dispatch_get_main_queue(),{
                
                self.longPlotSummaryTextField.text = longPlot
                
            })
            
            
            
        }

        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
  
    

}
