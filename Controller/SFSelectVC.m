//
//  SFSelectVC.m
//  iseasoftCompany
//
//  Created by songfei on 2018/4/19.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import "SFSelectVC.h"
#import "SFTitleView.h"
static NSString *const CellID = @"CellID";
@interface SFSelectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SFTitleView *titleView;// 选择头部
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray<NSMutableArray<SFSelectModel*>*> *allModelArray;//全部的数据
@property (nonatomic ,strong) NSMutableArray<SFSelectModel *> *midelModels;//中间分类
@end

@implementation SFSelectVC{
    SFSelectModel *lastSelctcModel;
    NSMutableArray<UIButton *> *btnArry;
}

- (instancetype)initWithFirstData:(NSMutableArray<SFSelectModel *>*)firstData{
    if (self = [super init]) {
        self.midelModels = firstData;
    }
    return self;
}

- (SFTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[SFTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _titleView.backgroundColor = [UIColor whiteColor];
        __weak typeof (self)weakSelf = self;
        _titleView.btnBlock = ^(NSInteger onClickBtn) {
            [weakSelf onClickBtn:onClickBtn];
        };
    }
    return _titleView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [UIView new];//不显示多余的分割线
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[SFSelectTableViewCell class] forCellReuseIdentifier:CellID];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5f];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
    [self setMasnory];
    btnArry = [NSMutableArray array];
    self.allModelArray = [NSMutableArray array];
    [self.tableView reloadData];
}
- (void)setMasnory{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(300);
    }];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.tableView.mas_top);
        make.left.mas_equalTo(self.tableView.mas_left);
        make.right.mas_equalTo(self.tableView.mas_right);
        make.height.mas_equalTo(44);
    }];
  
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.midelModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SFSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    if(!cell){
        cell = [[SFSelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    [cell setModel:self.midelModels[indexPath.row]];
    return cell;
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    __weak typeof (self)weakSelf = self;
    SFSelectModel *clickModel = self.midelModels[indexPath.row];
    
    NSIndexPath *lastIndexPath;
    if (lastSelctcModel == clickModel){
        
    }else if (lastSelctcModel.depth == clickModel.depth){
        if (lastSelctcModel) {
            NSInteger row = [self.midelModels indexOfObject:lastSelctcModel];
            lastIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        }
        
        for (SFSelectModel *mod in self.midelModels) {
            mod.isSelect = false;
        }
        self.midelModels[indexPath.row].isSelect = true;
        
        [self.titleView removeBtnWitBtn:btnArry.lastObject];
        [btnArry removeLastObject];
        UIButton *btn = [self.titleView addOneButton:clickModel.name];
        [btnArry addObject:btn];
        
        lastSelctcModel = clickModel;
        
    }else{
        lastSelctcModel = clickModel;
        self.midelModels[indexPath.row].isSelect = true;
        
        UIButton *btn = [self.titleView addOneButton:clickModel.name];
        [btnArry addObject:btn];
    }
    
    
    if (self.dataSource) {
        [self.dataSource sFSelectVCSourceBackWithDepth:clickModel.depth+1 regionId:clickModel.regionId block:^(NSMutableArray<SFSelectModel *> *models) {
            if (models.count > 0) {
                if (!(weakSelf.allModelArray.lastObject.lastObject.depth == weakSelf.midelModels.lastObject.depth) || weakSelf.allModelArray.count == 0) {
                    [weakSelf.allModelArray addObject:weakSelf.midelModels];
                }
                
                 weakSelf.midelModels = models;
                [weakSelf.tableView reloadData];
            }else{
                if (!(weakSelf.allModelArray.lastObject.lastObject.depth == weakSelf.midelModels.lastObject.depth) || weakSelf.allModelArray.count == 0) {
                    [weakSelf.allModelArray addObject:weakSelf.midelModels];
                }
                
                if (lastIndexPath) {
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[lastIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                }
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }

}

#pragma mark --点击了BTN
- (void)onClickBtn:(NSInteger)index{
    if (index < 0) {
        if (self.delegate) {
            NSInteger firstRegionId = 0;
            NSInteger lastRegionId = 0;
            NSString *adressStr = @"";
            for (int i = 0; i < self.allModelArray.count; i++) {
                if (i == 0) {
                    for (SFSelectModel *model in self.allModelArray[i]) {
                        if (model.isSelect) {
                            firstRegionId = model.regionId;
                            adressStr = [adressStr stringByAppendingString:model.name];
                        }
                    }
                }else if (i == (self.allModelArray.count - 1)){
                    for (SFSelectModel *model in self.allModelArray[i]) {
                        if (model.isSelect) {
                            lastRegionId = model.regionId;
                             adressStr = [adressStr stringByAppendingString:model.name];
                        }
                    }
                }else{
                    for (SFSelectModel *model in self.allModelArray[i]) {
                        if (model.isSelect) {
                            lastRegionId = model.regionId;
                            adressStr = [adressStr stringByAppendingString:model.name];
                        }
                    }
                }
                
            }
            if ([adressStr isEqualToString:@""]) {
                [self dismissViewControllerAnimated:true completion:nil];
                return;
            }
            [self.delegate sFSelectVCDidChange:adressStr firstRegionId:firstRegionId lastRegionId:lastRegionId];
        }
        [self dismissViewControllerAnimated:true completion:nil];
        return;
    }
    
    
    if (btnArry.count == (index +1)) {
        return;
    }
    
    for (NSInteger i = index + 1; i < btnArry.count; i++) {
        UIButton* btn = btnArry[i];
        [self.titleView removeBtnWitBtn:btn];
    }
    
    [btnArry removeObjectsInRange:NSMakeRange(index+1, btnArry.count - (index + 1))];
    [self.allModelArray removeObjectsInRange:NSMakeRange(index+1, self.allModelArray.count - (index +1))];
    self.midelModels = self.allModelArray.lastObject;
    
    [self.tableView reloadData];
    
    NSIndexPath *nowPath;
    for (SFSelectModel *model in self.midelModels) {
        if (model.isSelect) {
            NSInteger atNub = [self.midelModels indexOfObject:model];
            nowPath = [NSIndexPath indexPathForRow:atNub inSection:0];
            lastSelctcModel = model;
        }
    }
    
    [self.tableView scrollToRowAtIndexPath:nowPath atScrollPosition:UITableViewScrollPositionMiddle animated:true];
}


//点击其他地方退出
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    point = [self.tableView.layer convertPoint:point fromLayer:self.view.layer];
    if (![self.tableView.layer containsPoint:point]) {
        point = [[touches anyObject] locationInView:self.view];
        point = [self.titleView.layer convertPoint:point fromLayer:self.view.layer];
        if (![self.titleView.layer containsPoint:point]){
           [self dismissViewControllerAnimated:true completion:nil];
        }
    }
}
@end
