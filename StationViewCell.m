//
//  StationViewCell.m
//  GetMeUtaJourney
//
//  Created by Cal Henrie on 3/12/15.
//  Copyright (c) 2015 calhenrie. All rights reserved.
//

#import "StationViewCell.h"

@interface StationViewCell()

@property (strong,nonatomic) UILabel *stopLabel;

@end

@implementation StationViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.stopLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 44)];
    self.stopLabel.text = @" 'Next Station Here'";
    
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

