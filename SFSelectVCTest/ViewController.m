//
//  ViewController.m
//  SFSelectVCTest
//
//  Created by songfei on 2018/4/20.
//  Copyright © 2018年 songfei. All rights reserved.
//

#import "ViewController.h"
#import "SFSelectVC.h"
@interface ViewController ()<SFSelectVCDataSource,SFSelectVCDelegate>
@property (nonatomic ,strong) SFSelectVC *sfvc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SFSelectModel *model = [[SFSelectModel alloc]init];
    model.name = @"1111";
    model.regionId = 2222;
    model.depth = 0;
    NSMutableArray<SFSelectModel*>* arry = [NSMutableArray array];
    [arry addObject:model];
    self.sfvc = [[SFSelectVC alloc]initWithFirstData:arry];//初始化你的数据
    self.sfvc.dataSource = self;
    self.sfvc.delegate = self;
    
    self.sfvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:self.sfvc animated:true completion:nil];
}
- (void)sFSelectVCSourceBackWithDepth:(NSInteger)depth regionId:(NSInteger)regionId block:(SoureBlock)block {
    NSMutableArray<SFSelectModel*>* arry = [NSMutableArray array];
    for (int i=0 ; i<10; i++) {
        SFSelectModel *model = [[SFSelectModel alloc]init];
        model.name = [NSString stringWithFormat:@"第%d",i];
        model.regionId = 2222 + i;
        model.depth = 1;
        [arry addObject:model];
    }
    if (block) {//根据深度与ID获取返回你的数据
        block(arry);
    }
}

- (void)sFSelectVCDidChange:(NSString *)adress firstRegionId:(NSInteger)firstRegionId lastRegionId:(NSInteger)lastRegionId {
    
}


@end
