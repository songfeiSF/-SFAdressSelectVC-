//
//  SFSelectModel.h
//  iseasoftCompany
//
//  Created by songfei on 2018/4/10.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFSelectModel : NSObject

//ID
@property (nonatomic ,assign) NSInteger regionId;
//上级区域ID
@property (nonatomic ,assign) NSInteger parentRegionId;
//名称
@property (nonatomic ,copy) NSString *name;
//层级
@property (nonatomic ,assign) NSInteger depth;
//是否是选中状态
@property (nonatomic ,assign) BOOL isSelect;
@end
