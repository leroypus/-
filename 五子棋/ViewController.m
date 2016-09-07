//
//  ViewController.m
//  五子棋
//
//  Created by wgj on 16/8/26.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "ViewController.h"
#import "GobangView.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *maskView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *stopButton;

@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) GobangView *gobangView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.gobangView = [[GobangView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:self.gobangView];
    
    self.maskView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.maskView];
    self.maskView.image = [UIImage imageNamed:@"launch"];
    self.maskView.contentMode = UIViewContentModeScaleAspectFill;
    self.maskView.userInteractionEnabled = YES;
    
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 475, 86, 25)];
    [self.maskView addSubview:self.startButton];
    [self.startButton setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.stopButton = [[UIButton alloc] initWithFrame:CGRectMake(166, 475, 86, 25)];
    [self.stopButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [self.maskView addSubview:self.stopButton];
}

- (void)resetButtonPressed:(UIButton *)button {
    
    [self.gobangView reset];
}

- (void)startButtonPressed:(UIButton *)button {
    
    [self.maskView removeFromSuperview];
}


@end
