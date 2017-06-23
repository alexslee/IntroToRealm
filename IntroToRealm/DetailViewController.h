//
//  DetailViewController.h
//  IntroToRealm
//
//  Created by Alex Lee on 2017-06-22.
//  Copyright © 2017 Alex Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "Furniture.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Room *detailItem;
@property (strong, nonatomic) RLMResults<Furniture *> *furnitureResults;
//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

