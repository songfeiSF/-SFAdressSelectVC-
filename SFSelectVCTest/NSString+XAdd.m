//
//  NSString+XAdd.m
//  pige
//
//  Created by 徐沛营 on 15/12/14.
//  Copyright © 2015年 pipge. All rights reserved.
//

#import "NSString+XAdd.h"

@implementation NSString (XAdd)

+(NSString*) nullToEmpty:(NSString*)source {
    if(!source) {
        return @"";
    }
    return source;
}

+(NSString *)binaryStringWithInteger:(NSInteger)value {
    NSMutableString *string = [NSMutableString string];
    while (value){
        [string insertString:(value & 1)? @"1": @"0" atIndex:0];
        value /= 2;
    }
    return string;
}

+(NSString *)reversedBinaryStringWithInteger:(NSInteger)value {
    NSMutableString *string = [NSMutableString string];
    while (value){
        [string insertString:(value & 1)? @"1": @"0" atIndex:string.length];
        value /= 2;
    }
    return string;
}

// 判断是否是 ASCII字符串
-(BOOL) isASCIIString {
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:@"^[0-9a-zA-Z-/:;()¥&@\".,?!'\\[\\]{}#%^*+=_|~<>$\\\\]+$" options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRange rang = [self rangeOfString:self];
    return self.length && [regex numberOfMatchesInString:self options:NSMatchingReportCompletion range:rang] == 1;
}

// 验证手机号码（不含国家码）
-(BOOL) isValidChinaMobilePhone {
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:@"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$" options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRange rang = [self rangeOfString:self];
    return self.length && [regex numberOfMatchesInString:self options:NSMatchingReportCompletion range:rang] == 1;
}

-(BOOL) isValidEmail {
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:@"^[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)*@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRange rang = [self rangeOfString:self];
    return self.length && [regex numberOfMatchesInString:self options:NSMatchingReportCompletion range:rang] == 1;
}


-(BOOL) isValidIDCardNo {
    if ([self isEqual:[NSNull null]] || (self.length != 15 && self.length != 18)) {
        return false;
    }
    //身份证正则表达式(15位)
   NSString* reg = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{2}[0-9X]$";
    if (self.length == 18) {//身份证正则表达式(18位)
        reg = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[0-9X]$";
    }
    
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:reg options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRange rang = [self rangeOfString:self];
    return self.length && [regex numberOfMatchesInString:self options:NSMatchingReportCompletion range:rang] == 1;
}

/**
 *  @brief 字母和汉字
 *
 */
-(BOOL) isWordAndChineseWordOnly {
    if ([self isEqual:[NSNull null]]) {
        return false;
    }
    NSString* reg = @"^[A-Za-z\\u4E00-\\u9FFF]+$";
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:reg options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRange rang = [self rangeOfString:self];
    return self.length && [regex numberOfMatchesInString:self options:NSMatchingReportCompletion range:rang] == 1;
}

// 计算字符串size
-(CGSize) boundingRectWithSize:(CGSize) size font:(UIFont*) font {
    NSDictionary* attr = @{NSFontAttributeName:font};
    
    CGSize reSize = [self boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attr
                                       context:nil].size;
    
    return reSize;
}

-(CGSize) sizeForFont:(UIFont*) font maxWidth:(CGSize) size {
    if (!self) {
        return CGSizeZero;
    }
    return [self boundingRectWithSize:size font:font maxWidth:size.width];
}

-(CGSize) boundingRectWithSize:(CGSize) size font:(UIFont*) font maxWidth:(CGFloat) maxW{
    NSArray *array = [self componentsSeparatedByString:@"/n"];
    array = [array sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        NSComparisonResult rlt;
        if (obj1.length > obj2.length) {
            rlt = NSOrderedAscending;
        } else if(obj1.length < obj1.length) {
            rlt = NSOrderedDescending;
        } else {
            rlt = NSOrderedSame;
        }
        return rlt;
    }];
    CGSize reSize = [array[0] boundingRectWithSize:size font:font];
    if(reSize.width > maxW){
        reSize = [self boundingRectWithSize:CGSizeMake(maxW, 300) font:font];
    } else {
        reSize = [self boundingRectWithSize:CGSizeMake(reSize.width, 300) font:font];
    }
    
    return reSize;
}

+(NSString*) atomicRandom {
    // 获取100到999之间的整数的代码如下:
    int value = (arc4random() % 999) + 100;
    NSLog(@"随机数 =  %d",value);
    
    return [NSString stringWithFormat:@"%0.0f%d", [NSDate timeIntervalSinceReferenceDate],value];
}


//计算一段字符串的长度，1个汉字占2个长度。
- (int)countStr {
    
    int strlength = 0;
    
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        
        if (*p) {
            
            p++;
            
            strlength++;
            
        }
        
        else {
            
            p++;
            
        }
        
    }
    
    return strlength;
    
}


/**
 *  参数要一一对应
 */
+(NSAttributedString*) attrString:(NSArray<NSString*>*)strs  fonts:(NSArray<UIFont*>*)fonts colors:(NSArray<UIColor*>*)colors{
    
    NSString* allStr = [[NSString alloc]init];
    for (NSString* str in strs) {
        allStr = [NSString stringWithFormat:@"%@%@",allStr,str];
    }
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    
    NSInteger length = 0 ;
    
    for(int i = 0; i< strs.count ;i++){
        
        NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
        
        if(i < fonts.count){
            UIFont* font = fonts[i];
            [dictionary setValue:font forKey:NSFontAttributeName];
        }
        
        if(i < colors.count){
            UIColor* color = colors[i];
            [dictionary setValue:color forKey:NSForegroundColorAttributeName];
        }
        
        if(!dictionary.count){
            NSLog(@"参数传的不对，数组之间要一一对应");
            break;
        }
        
        NSString* str = strs[i];
        [attrStr setAttributes:dictionary range:NSMakeRange(length, str.length)];
        
        length = length + str.length;
    }
    
    return attrStr;
}


+(NSMutableAttributedString*) attrStringAndAlignmentCenter:(NSArray<NSString*>*)strs  fonts:(NSArray<UIFont*>*)fonts colors:(NSArray<UIColor*>*)colors{
    
    NSString* allStr = [[NSString alloc]init];
    for (NSString* str in strs) {
        allStr = [NSString stringWithFormat:@"%@%@",allStr,str];
    }
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    
    NSInteger length = 0 ;
    
    for(int i = 0; i< strs.count ;i++){
        
        NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
        
        if(i < fonts.count){
            UIFont* font = fonts[i];
            [dictionary setValue:font forKey:NSFontAttributeName];
        }
        
        if(i < colors.count){
            UIColor* color = colors[i];
            [dictionary setValue:color forKey:NSForegroundColorAttributeName];
        }
        
        if(!dictionary.count){
            NSLog(@"参数传的不对，数组之间要一一对应");
            break;
        }
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:6];
        paragraphStyle.alignment =  NSTextAlignmentCenter;
        [dictionary setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
        
        
        
        NSString* str = strs[i];
        [attrStr setAttributes:dictionary range:NSMakeRange(length, str.length)];
        
        length = length + str.length;
    }
    
    return attrStr;
}
//获取设备类型
+ (NSString*)deviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X";
    return deviceString;
}

@end
