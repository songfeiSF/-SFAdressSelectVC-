//
//  SFSelectTableViewCell.m
//  iseasoftCompany
//
//  Created by songfei on 2018/4/10.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import "SFSelectTableViewCell.h"
#import <Masonry.h>


@interface SFSelectTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *selectImageView;
@end
@implementation SFSelectTableViewCell
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline01"]];
    }
    return _selectImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
        [self layoutSetMasonry];
    }
    return self;
}

- (void)initSubView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.selectImageView];
}
- (void)layoutSetMasonry{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
}

- (void)setModel:(SFSelectModel*)model{
    if(!model.name)return;
    self.titleLabel.text = model.name;
    if (model.isSelect) {
        self.selectImageView.hidden = false;
    }else{
        self.selectImageView.hidden = true;
    }
}
@end
