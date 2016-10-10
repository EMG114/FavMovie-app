//
//  TrailerPlayerViewController.m
//  MovieApp
//
//  Created by Erica on 10/5/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

#import "TrailerPlayerViewController.h"
//#import "XCDYouTubeKit/XCDYouTubeKit.h"
#import "YTPlayerView.h"




@interface TrailerPlayerViewController ()

@property (weak, nonatomic, readwrite) IBOutlet UILabel *theMovieTitle;

@property (weak, nonatomic) IBOutlet UILabel *releasedYear;


@end



@implementation TrailerPlayerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//[self.playerView setDelegate: self];
    
    [self.playerView loadWithVideoId:@"TUhvdGeN1ao"];
  
    
  //  _releasedYear.text = movie.movieYear
 //   _theMovieTitle.text = movie.movieYear
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
