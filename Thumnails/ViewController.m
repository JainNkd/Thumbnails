//
//  ViewController.m
//  Thumnails
//
//  Created by Naveen Kumar Dungarwal on 3/18/15.
//  Copyright (c) 2015 Naveen Kumar Dungarwal. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *baseURL = [bundle pathForResource:@"Videos/Big_Buck_Bunny_Trailer" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:baseURL];
    
    MPMoviePlayerViewController *videoVC = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    [videoVC.moviePlayer prepareToPlay];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MPMoviePlayerLoadStateDidChange:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:videoVC];
    //Find time duration of video
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    CMTime time = [asset duration];
    
    CGFloat videoDuration = time.value/time.timescale;
    
    CGFloat frame1 = (videoDuration*0.33);
    CGFloat frame2 = (videoDuration*0.66);
    CGFloat frame3 = (videoDuration*0.99);
    
        self.thumnail1.image = [videoVC.moviePlayer thumbnailImageAtTime:frame1 timeOption:MPMovieTimeOptionExact];
        self.thumbnail2.image = [videoVC.moviePlayer thumbnailImageAtTime:frame2 timeOption:MPMovieTimeOptionExact];
        self.thumbnail3.image = [videoVC.moviePlayer thumbnailImageAtTime:frame3 timeOption:MPMovieTimeOptionExact];
    
//    NSArray *timesArr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%.02f",frame1],[NSString stringWithFormat:@"%.02f",frame2],[NSString stringWithFormat:@"%.02f",frame3], nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieThumbnailLoadComplete:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:videoVC];
//    
//    [videoVC.moviePlayer requestThumbnailImagesAtTimes:timesArr timeOption:MPMovieTimeOptionExact];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)movieThumbnailLoadComplete:(NSNotification *)receive
{
    NSDictionary *receiveInfo = [receive userInfo];
//    UIImageView *tmpImage = [[UIImageView alloc] initWithImage:[receiveInfo valueForKey:MPMoviePlayerThumbnailImageKey]];
//    [tmpImage setFrame:CGrectMake(0, 0, 320, 180)];
//    
//    [self.view addsubView:tmpImage];
}

- (void)MPMoviePlayerLoadStateDidChange:(NSNotification *)notification
{
    MPMoviePlayerViewController *movie = [notification object];
    if ((movie.moviePlayer.loadState & MPMovieLoadStatePlaythroughOK) == MPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"content play length is %g seconds", movie.moviePlayer.duration);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playVideo:(UIButton *)sender {

//    NSString * baseURL = [NSString stringWithFormat:@"%@/67722163_30221058_45098209.mp4",[[NSBundle mainBundle] bundlePath]];
   
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *baseURL = [bundle pathForResource:@"Videos/Big_Buck_Bunny_Trailer" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:baseURL];
    
    MPMoviePlayerViewController *videoVC = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    videoVC.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    [self presentMoviePlayerViewControllerAnimated:videoVC];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoVC];
    
    [videoVC.moviePlayer play];
    
}

-(void)videoPlayFinish:(NSNotification *) aNotification
{
    MPMoviePlayerViewController *movieVC = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:movieVC];
    
    [movieVC.moviePlayer stop];
}
@end
