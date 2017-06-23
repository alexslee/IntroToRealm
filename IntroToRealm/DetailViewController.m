//
//  DetailViewController.m
//  IntroToRealm
//
//  Created by Alex Lee on 2017-06-22.
//  Copyright © 2017 Alex Lee. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Room *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSPredicate *roomPredicate = [NSPredicate predicateWithFormat:@"room = %@", self.detailItem];
        self.furnitureResults = [Furniture objectsWithPredicate:roomPredicate];
        //self.detailDescriptionLabel.text = [self.detailItem description];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self configureView];
}

- (void)insertNewObject:(id)sender {
    //basically same code as in the master view controller
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add New Furniture" message:@"Give your furniture a name:" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Furniture name";
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
    }];
    
    UIAlertAction *add = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSString *input = alertController.textFields[0].text;
        Furniture *newFurniture = [[Furniture alloc] init];
        newFurniture.name = input;
        newFurniture.room = self.detailItem;
        //save to the view controller as well as to Realm
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:newFurniture];
        [realm commitWriteTransaction];
        
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:([self.furnitureResults count] - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:add];
    [self.tableView reloadData];
    [self presentViewController:alertController animated: YES completion: nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.furnitureResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.furnitureResults objectAtIndex:indexPath.row].name;
    return cell;
}


@end
