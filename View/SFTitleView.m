//
//  SFTitleView.m
//  iseasoftCompany
//
//  Created by songfei on 2018/4/10.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import "SFTitleView.h"
#import "NSString+XAdd.h"
#import "UIView+Frame.h"
static NSInteger const btnTag = 5000;
@interface SFTitleView()
@property (nonatomic ,strong)UIButton *cancelBtn;
@property (nonatomic ,strong)UIButton *btnLast;
@property (nonatomic ,strong)UIView *line;
@property (nonatomic ,strong)UIView *spLine;//分割线
@end
@implementation SFTitleView
- (UIView *)spLine{
    if (!_spLine) {
        _spLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
        _spLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _spLine;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, 0, 2)];
        _line.backgroundColor = [UIColor redColor];
    }
    return _line;
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]init];
        _cancelBtn.frame = CGRectMake(self.frame.size.width - 60, 2, 60, 40);
        [_cancelBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelBtn.tag = 4000;
        [_cancelBtn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cancelBtn];
        [self addSubview:self.line];
        [self addSubview:self.spLine];
    }
    return self;
}

- (UIButton *)addOneButton:(NSString *)text{
    UIButton *btn = [[UIButton alloc]init];
    if (!text) {
        text = @"请选择";
    }
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    CGSize size = [text sizeForFont:[UIFont systemFontOfSize:14] maxWidth:CGSizeMake(150, 40)];
     btn.selected = true;
    
    UIButton *lastBtn;
    if(self.btnLast){
        lastBtn = self.btnLast;
        btn.frame = CGRectMake(self.btnLast.right + 10, 2, size.width, 40);
        btn.tag = self.btnLast.tag + 1;
    }else{
        btn.frame = CGRectMake(10, 2, size.width, 40);
        btn.tag = btnTag;
    }
    [btn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.btnLast = btn;
    [self addSubview:btn];
    [UIView animateWithDuration:0.5 animations:^{
        self.line.left = btn.left;
        self.line.width = btn.width;
        [self layoutIfNeeded];
    }];
    
    if(lastBtn){//防止动画带动上个btn
        lastBtn.selected = false;
    }
    
    return btn;
}


- (void)onClickBtn:(UIButton *)btn{
    if (btn.tag == 4000) {
        if(self.btnBlock){
            self.btnBlock(btn.tag - btnTag);
        }
    }else{
        btn.selected = true;
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                if (!(btn == view)) {
                    UIButton *newBtn = (UIButton *)view;
                    newBtn.selected = false;
                }
            }
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.line.left = btn.left;
            self.line.width = btn.width;
            [self layoutIfNeeded];
        }];
        if(self.btnBlock){
            self.btnBlock(btn.tag - btnTag);
        }
    }
  
}

- (void)removeBtnWitBtn:(UIButton *)btn{
    if (btn.tag == btnTag) {
        self.btnLast = nil;
    }else{
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                if(view.tag == (btn.tag - 1)){
                    self.btnLast = (UIButton*)view;
                }
            }
        }
    }
     [btn removeFromSuperview];
}

- (void)removeDownButton:(UIButton *)btn{
    self.btnLast = btn;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if(view.tag > btn.tag){
                [view removeFromSuperview];
            }
        }
    }
}
@end
