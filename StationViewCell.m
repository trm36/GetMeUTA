//
//  StationViewCell.m
//  GetMeUtaJourney
//
//  Created by Cal Henrie on 3/12/15.
//  Copyright (c) 2015 calhenrie. All rights reserved.
//

#import "StationViewCell.h"
#import "NSObject+UIColor.h"

@interface StationViewCell()

@property (strong,nonatomic) UILabel *stopLabel;
@property (strong,nonatomic) UILabel *timeLable;

@end

@implementation StationViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
    self.timeLable.text = @"8:15 pm";
    self.timeLable.textColor = [UIColor darkBlue];
    [self.contentView addSubview:self.timeLable];
    
    self.stopLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, self.contentView.frame.size.width, 44)];
    self.stopLabel.text = @"Court House Station";
    self.stopLabel.textColor = [UIColor darkBlue];
    [self.contentView addSubview:self.stopLabel];
    
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

