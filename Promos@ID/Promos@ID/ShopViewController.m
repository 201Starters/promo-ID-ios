//
//  ShopViewController.m
//  Promos@ID
//
//  Created by Farandi Kusumo on 1/21/15.
//  Copyright (c) 2015 Farandi Kusumo. All rights reserved.
//

#import "ShopViewController.h"
#import "Shop.h"
#import "ShopDetailViewController.h"
#import "UITabBarController+hidable.h"

@interface ShopViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ShopViewController{
    NSArray *shops;
    NSArray *searchResults;
	CGFloat startContentOffset;
	CGFloat lastContentOffset;
	BOOL hidden;
}
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
	hidden = NO;
    [self initiateVariable];
	
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

}

//-(void)viewWillAppear:(BOOL)animated
//{
//	[super viewWillAppear:animated];
//	
//	[self.navigationController setNavigationBarHidden:hidden
//											 animated:YES];
//	
//}
//
//-(void)viewDidAppear:(BOOL)animated
//{
//	[super viewDidAppear:animated];
//	[self.tabBarController setTabBarHidden:hidden
//								  animated:NO];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate and data source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ShopCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Shop *shop = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        shop = [searchResults objectAtIndex:indexPath.row];
    } else{
        shop = [shops objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = shop.name;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    }
    else {
        return [shops count];
    }
}

#pragma mark - search method

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [shops filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}


#pragma mark - initial dummy variable

-(void)initiateVariable
{
    Shop *iBox = [Shop new];
    iBox.name = @"iBox";
    iBox.location = [NSArray arrayWithObjects:@"Mall Kelapa Gading",@"Pondok Indah Mall",nil];
    iBox.image = @"ibox.png";
    iBox.web = @"ibox.co.id";

    Shop *uniqlo = [Shop new];
    uniqlo.name = @"Uniqlo";
    uniqlo.location = [NSArray arrayWithObjects:@"Pondok Indah Mall",@"Grand Indonesia Shopping Town", nil];
    uniqlo.image = @"uniqlo.png";
    uniqlo.web = @"uniqlo.com";

    Shop *zara = [Shop new];
    zara.name = @"ZARA";
    zara.location = [NSArray arrayWithObjects:@"Grand Indonesia Shopping Town",@"Mall Kelapa Gading", nil];
    zara.image = @"zara.png";
    zara.web = @"zara.com";
    
    shops = [NSArray arrayWithObjects:iBox,uniqlo,zara, nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showShopDetail"]) {
        NSIndexPath *indexPath = nil;
        Shop *shop = nil;
        
        if(self.searchDisplayController.active)
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            shop = [searchResults objectAtIndex:indexPath.row];
        } else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
            shop = [shops objectAtIndex:indexPath.row];
        }
        
        ShopDetailViewController *destViewController = segue.destinationViewController;
        destViewController.shop = shop;
    }
}
//
//#pragma mark - Hide TabBar and NavBar
//
//-(void)expand
//{
//	if(hidden)
//		return;
//	
//	hidden = YES;
//	
//	[self.tabBarController setTabBarHidden:YES
//								  animated:YES];
//	
//	[self.navigationController setNavigationBarHidden:YES
//											 animated:YES];
//}
//
//-(void)contract
//{
//	if(!hidden)
//		return;
//	
//	hidden = NO;
//	
//	[self.tabBarController setTabBarHidden:NO
//								  animated:YES];
//	
//	[self.navigationController setNavigationBarHidden:NO
//											 animated:YES];
//}
//
//#pragma mark UIScrollViewDelegate Methods
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//	startContentOffset = lastContentOffset = scrollView.contentOffset.y;
//	//NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//	CGFloat currentOffset = scrollView.contentOffset.y;
//	CGFloat differenceFromStart = startContentOffset - currentOffset;
//	CGFloat differenceFromLast = lastContentOffset - currentOffset;
//	lastContentOffset = currentOffset;
//	
//	
//	
//	if((differenceFromStart) < 0)
//	{
//		// scroll up
//		if(scrollView.isTracking && (abs(differenceFromLast)>1))
//			[self expand];
//	}
//	else {
//		if(scrollView.isTracking && (abs(differenceFromLast)>1))
//			[self contract];
//	}
//	
//}
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//	[self contract];
//	return YES;
//}
//
@end
