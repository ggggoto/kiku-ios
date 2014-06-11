//
//  TTTableViewCell.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/06/12.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTTableViewCell.h"

@implementation TTTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            // configure control(s)
            self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
            self.descriptionLabel.textColor = [UIColor blackColor];
            self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
            
            [self addSubview:self.descriptionLabel];
        }
        return self;
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
