//
//  TrailerPlayerViewController.h
//  MovieApp
//
//  Created by Erica on 10/5/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"


@interface TrailerPlayerViewController : UIViewController

@property (nonatomic, strong) NSString *videoID;
//@property (nonatomic) NSInteger trailerVideoIndex;
//

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

//@property(nonatomic, strong) NSString *movieTitle;
//
//@property(nonatomic, strong) NSString *releasedYear;
//

@end
