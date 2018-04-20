//
//  NSString+XAdd.h
//  pige
//
//  Created by 徐沛营 on 15/12/14.
//  Copyright © 2015年 pipge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "sys/utsname.h"
@interface NSString (XAdd)

/**
 *  @brief nil to @""
 *
 *  @return @"" if nil,or self
 */
+(NSString*) nullToEmpty:(NSString*)source;

// 把value转为二进制形式
+(NSString *)binaryStringWithInteger:(NSInteger)value ;
// 反序二进制形式
+(NSString *)reversedBinaryStringWithInteger:(NSInteger)value;

/**
 *  @author 徐沛营, 15/07/29
 *
 *  @brief  判断字符串是否由ASCII字符构成
 *
 *  @return true 如果是ASCII
 */
-(BOOL) isASCIIString;

/**
 *  @author 徐沛营, 15/07/29
 *
 *  @brief  验证手机号码（不含国家码）
 *
 *  @return true,如果是合法的中国手机号码
 */
-(BOOL) isValidChinaMobilePhone;

/**
 *  @author 徐沛营, 16/06/24
 *
 *  @brief  验证电子邮件
 *
 *  @return true,如果是合法的邮箱地址
 */
-(BOOL) isValidEmail;

/**
 *  @brief 验证合法的身份证
 *
 */
-(BOOL) isValidIDCardNo;

/**
 *  @brief 字母和汉字
 *
 */
-(BOOL) isWordAndChineseWordOnly;

/**
 根据字体，计算文字所占Size

 @param font 文字字体
 @param size 最小Size
 @return 文字所占Size
 */
-(CGSize) sizeForFont:(UIFont*) font maxWidth:(CGSize) size;
-(CGSize) boundingRectWithSize:(CGSize) size font:(UIFont*) font maxWidth:(CGFloat) maxW;

/**
 * 原子随机数
 **/
+(NSString*) atomicRandom;

- (int)countStr;


/**
 *  @brief 动态添加文字属性
 *
 *  @param strs 字符串 分段 数组
 *  @param fonts 对应字符串 大小
 *  @param colors 对应字符串 颜色
 */
+(NSAttributedString*) attrString:(NSArray<NSString*>*)strs  fonts:(NSArray<UIFont*>*)fonts colors:(NSArray<UIColor*>*)colors;


/**
 *  与上相同但是居中
 */
+(NSMutableAttributedString*) attrStringAndAlignmentCenter:(NSArray<NSString*>*)strs  fonts:(NSArray<UIFont*>*)fonts colors:(NSArray<UIColor*>*)colors;

+ (NSString*)deviceVersion;
@end
