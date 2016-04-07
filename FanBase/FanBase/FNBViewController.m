//
//  FNBViewController.m
//  FanBase
//
//  Created by Mariya Eggensperger on 4/6/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "FNBViewController.h"
#import "FNBCollectionViewCell.h"
#import "FNBTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "FNBFirebaseClient.h"
#import <Firebase.h>

@interface FNBViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *imageArray; //-->currently colors 
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@property (nonatomic, strong) NSDictionary *content;
@property (nonatomic, strong) NSArray *genres;

@end

@implementation FNBViewController

-(void)loadView
{
    [super loadView];
    
    const NSInteger numberOfTableViewRows = 1;
    const NSInteger numberOfCollectionViewCells = 20;
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:numberOfTableViewRows];
    
    for (NSInteger tableViewRow = 0; tableViewRow < numberOfTableViewRows; tableViewRow++)
    {
        NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:numberOfCollectionViewCells];
        
        for (NSInteger collectionViewItem = 0; collectionViewItem < numberOfCollectionViewCells; collectionViewItem++)
        {
            
            CGFloat red = arc4random() % 255;
            CGFloat green = arc4random() % 255;
            CGFloat blue = arc4random() % 255;
            
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
            
            
            //add images of artist albums see xib for structure
            
            [imageArray addObject:color];
        }
        
        [mutableArray addObject:imageArray];
    }
    
    self.imageArray = [NSArray arrayWithArray:mutableArray];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // dictionary to hold all content for display
    // key is genre
    // value is array of artists for genre
    self.content = @{
                     @"Pop" : @[@"Maroon 5",@"Adele",@"Gwen Stefani",@"Ariana Grande"],
                     @"Rock" : @[@"AC/DC",@"Guns n'Roses"],
                     @"Hip-Hop" : @[@"Jay-Z",@"Drake",@"Run DMC",@"Beyonce"]
};
    
    NSDictionary *sampleDictionary = @{
                                       @"Genre" : @[@{@"Artist":@"ArtistImageURL"}]
                                       };
    
    // grab all keys (all genres) from content dictionary
    NSArray *genreKeys = [self.content allKeys];
    // sort all keys alphabetically and put into genres array
    self.genres = [genreKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
}
-(BOOL)prefersStatusBarHidden {
    
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // count all keys (genres) in content dictionary
    // to establish number of sections needed in tableview
    return self.content.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.genres[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"\n\n\nTableView cell: %li\n\n\n",indexPath.row);
    static NSString *CellIdentifier = @"CellIdentifier";
    
    FNBTableViewCell *cell = (FNBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[FNBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(FNBTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.tag;
    
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
    
    [cell.collectionView registerClass:[FNBCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    
}

#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSLog(@"\n\n\nCollectionView section: %li\n\n\n",section);
    
    // grab superview of collectionView which is UITableViewCellContentView
    UIView *view = [collectionView superview];
    // grab FNBTableViewCell from superview of UITableViewCellContentView
    FNBTableViewCell *cell = (FNBTableViewCell *)[view superview];
    // get index path of cell
    NSIndexPath *ip = [self.tableView indexPathForCell:cell];
    // get section number from index path
    NSInteger tableViewSection = ip.section;
    // get genre from genres array
    NSString *genre = self.genres[tableViewSection];
    // get all artists from content dictionary
    NSArray *artists = self.content[genre];
    
    return artists.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    FNBCollectionViewCell *cell = (FNBCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
   
    
//    //make custom cells for this stuff
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
//    [cell addSubview:label];
//    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [collectionView superview];
    FNBTableViewCell *tableViewCell = (FNBTableViewCell *)[view superview];
    NSIndexPath *ip = [self.tableView indexPathForCell:tableViewCell];
    NSInteger tableViewSection = ip.section;
    NSString *genre = self.genres[tableViewSection];
    NSArray *artists = self.content[genre];
    
    NSLog(@"\n\n\ncell for item at index path\n\nindex path item: %li\n\n\n",indexPath.item);
    cell.artist = artists[indexPath.item];
    cell.image = [UIImage imageNamed:@"adele"];
//    NSLog(@"label text: %@", label.text);
    
    NSArray *collectionViewArray = self.imageArray[[(FNBIndexedCollectionView *)collectionView indexPath].row];
    cell.backgroundColor = collectionViewArray[indexPath.item];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    NSInteger index = collectionView.tag;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

@end