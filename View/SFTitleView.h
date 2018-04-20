//
//  SFTitleView.h
//  iseasoftCompany
//
//  Created by songfei on 2018/4/10.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
typedef void(^BtnBlock)(NSInteger onClickBtn);
@interface SFTitleView : UIView
@property (nonatomic ,copy)BtnBlock btnBlock;

- (UIButton *)addOneButton:(NSString *)text;

- (void)removeBtnWitBtn:(UIButton *)btn;
- (void)removeDownButton:(UIButton *)btn;
@end
