//
//  ViewController.m
//  BDWaveForm
//
//  Created by T on 17/2/28.
//  Copyright © 2017年 benbun. All rights reserved.
//

#import "ViewController.h"
#import "WaveForm.h"

#define SCREEN_WIDTH  CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

static NSString *const CELL_IDENTIFIER = @"CELL_IDENTIFIER";
static const CGFloat WAVEFORM_HEIGHT = 200.f;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) WaveForm *headerView;
@end

@implementation ViewController

#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    self.tableView.rowHeight = 44.f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    self.headerView = [[WaveForm alloc] init];
    self.headerView.backgroundColor = RGBACOLOR(248, 64, 87, 1);
    [self.headerView startAnimation];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)viewDidLayoutSubviews{
    
    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.headerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, WAVEFORM_HEIGHT)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    if (self.tableView) {
        self.tableView.delegate = nil;
        self.tableView.dataSource = nil;
    }
}


#pragma mark - datasource/delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [NSString stringWithFormat:@"显示的行号😊%tu", indexPath.row];
    cell.textLabel.text = title;
}

@end
