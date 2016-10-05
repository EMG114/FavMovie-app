//
//  TrailerPlayerViewController.m
//  MovieApp
//
//  Created by Erica on 10/5/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

#import "TrailerPlayerViewController.h"
#import "XCDYouTubeKit/XCDYouTubeKit.h"


static void *kMoviePlayerContentURLContext = &kMoviePlayerContentURLContext;
static NSString *kKeyPath = @"moviePlayer.contentURL";


@interface TrailerPlayerViewController ()

@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *trailerPlayerViewController;


@end

@implementation TrailerPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
