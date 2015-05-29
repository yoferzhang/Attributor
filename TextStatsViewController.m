//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Lucifer Zhang on 5/25/15.
//  Copyright (c) 2015 LuciferZhang. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    unsigned long index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName
                                         atIndex:index
                                  effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    
    return characters;
}

- (void)updateUI {
    NSLog(@"%lu", (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]);
    NSLog(@"%@", [self charactersWithAttribute:NSForegroundColorAttributeName]);
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colouful characters!", (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters!", (unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];

}

@end
