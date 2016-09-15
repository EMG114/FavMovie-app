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
   
    let store = MovieDataStore.sharedStore
    
    @IBOutlet weak var longPlotSummaryTextField: UITextView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       self.title = "Full Plot"
        
         view.backgroundColor = UIColor.darkGrayColor()
        longPlotSummaryTextField.backgroundColor = UIColor.darkGrayColor()
        
       guard let unwrappedMoviePlot = movie else {return}
        self.store.getLongSummaryPlot(unwrappedMoviePlot) {
        
       // OmdbAPIClient().getMovieLongPlot(unwrappedMoviePlot){success in
            dispatch_async(dispatch_get_main_queue(),{
               self.longPlotSummaryTextField.text = self.movie?.movieLongPlot
            })
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
  
    

}
