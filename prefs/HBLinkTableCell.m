#import "HBLinkTableCell.h"
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIImage+Private.h>

@implementation HBLinkTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
		self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"safari" inBundle:globalBundle]];

		self.detailTextLabel.numberOfLines = 0;
		self.detailTextLabel.text = specifier.properties[@"subtitle"] ?: @"";

		if (specifier.properties[@"initials"]) {
			CGFloat size = 29.f;

			UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, [UIScreen mainScreen].scale);
			specifier.properties[@"iconImage"] = UIGraphicsGetImageFromCurrentImageContext();
			UIGraphicsEndImageContext();

			UIView *avatarView = [[UIView alloc] initWithFrame:self.imageView.bounds];
			avatarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			avatarView.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1];
			avatarView.userInteractionEnabled = NO;
			avatarView.clipsToBounds = YES;
			avatarView.layer.cornerRadius = size / 2;
			[self.imageView addSubview:avatarView];

			UILabel *label = [[UILabel alloc] initWithFrame:avatarView.bounds];
			label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			label.font = [UIFont systemFontOfSize:13.f];
			label.textAlignment = NSTextAlignmentCenter;
			label.textColor = [UIColor whiteColor];
			label.text = specifier.properties[@"initials"];
			[avatarView addSubview:label];
		}
	}

	return self;
}

#pragma mark - Tint color

- (void)tintColorDidChange {
	[super tintColorDidChange];

	if (self.type == PSButtonCell) {
		self.textLabel.textColor = self.tintColor;
	}
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];

	if (self.type == PSButtonCell && [self respondsToSelector:@selector(setTintColor:)]) {
		self.textLabel.textColor = self.tintColor;
	}
}

@end
