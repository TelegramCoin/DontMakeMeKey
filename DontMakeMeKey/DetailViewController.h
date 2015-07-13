//
//  DetailViewController.h
//  DontMakeMeKey
//
//  Created by nevyn Bengtsson on 2015-07-13.
//  Copyright (c) 2015 nevyn Bengtsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

