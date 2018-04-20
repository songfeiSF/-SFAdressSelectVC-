//
//  SFSelectVC.h
//  iseasoftCompany
//
//  Created by songfei on 2018/4/19.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFSelectModel.h"
#import "SFSelectTableViewCell.h"
typedef void (^SoureBlock)(NSMutableArray<SFSelectModel*> *models);
@protocol SFSelectVCDataSource <NSObject>
- (void)sFSelectVCSourceBackWithDepth:(NSInteger)depth regionId:(NSInteger)regionId block:(SoureBlock)block;
@end
@protocol SFSelectVCDelegate <NSObject>
- (void)sFSelectVCDidChange:(NSString*)adress firstRegionId:(NSInteger)firstRegionId lastRegionId:(NSInteger)lastRegionId;
@end
@interface SFSelectVC : UIViewController
@property (nonatomic ,weak) id<SFSelectVCDataSource> dataSource;
@property (nonatomic ,weak) id<SFSelectVCDelegate> delegate;


- (instancetype)initWithFirstData:(NSMutableArray<SFSelectModel *>*)firstData;
@end
