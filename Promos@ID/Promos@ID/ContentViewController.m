//
//  RecommendedContentViewController.m
//  Promos@ID
//
//  Created by Farandi Kusumo on 1/16/15.
//  Copyright (c) 2515 Farandi Kusumo. All rights reserved.
//

#import "ContentViewController.h"
#import "Promo.h"
#import "PromoViewCell.h"
#import "PromoDetailViewController.h"
#import "UITabBarController+hidable.h"

@interface ContentViewController ()

@end

@implementation ContentViewController{
    NSArray *promos;
	CGFloat startContentOffset;
	CGFloat lastContentOffset;
	BOOL hidden;
}
@synthesize pageIndex;
//@synthesize promoView;

- (void)viewDidLoad {
    [super viewDidLoad];
	hidden = NO;
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.titleText;
    /*CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionPromo = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];*/
    CHTCollectionViewWaterfallLayout* customLayout = (CHTCollectionViewWaterfallLayout*)self.collectionPromo.collectionViewLayout;
    customLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self initiateVariable];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.navigationController setNavigationBarHidden:hidden
											 animated:YES];
	
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.tabBarController setTabBarHidden:hidden
								  animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [promos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PromoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PromoCell" forIndexPath:indexPath];
    Promo *promo = nil;
    promo = [promos objectAtIndex:indexPath.item];
    
    CGRect rectReference = cell.bounds;
    
    PNCollectionCellBackgroundView* backgroundView = [[PNCollectionCellBackgroundView alloc] initWithFrame:rectReference];
    cell.backgroundView = backgroundView;
    
    UIView* selectedBackgroundView = [[UIView alloc] initWithFrame:rectReference];
    selectedBackgroundView.backgroundColor = [UIColor clearColor];   // no indication of selection
    cell.selectedBackgroundView = selectedBackgroundView;
    
    
    UIImage*image=[UIImage imageNamed:promo.poster_small];
    CGFloat ratio=(image.size.height/image.size.width);
    CGRect imageViewFrame = CGRectMake(0, 0, (self.view.frame.size.width-25)/2, ratio*(self.view.frame.size.width-25)/2);
    cell.poster.frame = imageViewFrame;
    CGSize size = CGSizeMake((self.view.frame.size.width-25)/2, ratio*(self.view.frame.size.width-25)/2);
    image=[self imageWithImage:image scaledToSize:size];
    cell.poster.image = image;
    cell.title.text = promo.title;
	cell.brand.text = promo.brand;
	cell.brandLogo_small.image = [UIImage imageNamed:promo.brand_logo];
    return cell;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UICollectionViewDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Promo *promo = nil;
    promo = [promos objectAtIndex:indexPath.item];
    UIImage *image;
    image = [UIImage imageNamed:promo.poster_small];
    CGFloat ratio=(image.size.height/image.size.width);
    CGSize size = CGSizeMake((self.view.frame.size.width-25) / 2, ((ratio*self.view.frame.size.width-25)/2)+ 125);
    return size;
}


#pragma mark - initiate dummy variable

-(void)initiateVariable
{
    Promo *etude_EOYSale    = [Promo new];
    etude_EOYSale.title     = @"Etude End of Year Sale";
    etude_EOYSale.brand     = @"Etude";
	etude_EOYSale.brand_logo= @"etudeEOYSale.png";
    etude_EOYSale.shop      = [NSArray arrayWithObjects:@"", nil];
    etude_EOYSale.location  = [NSArray arrayWithObjects:@"", nil];
    etude_EOYSale.poster_small= @"etudeEOYSale.png";
    etude_EOYSale.poster_big  = @"";
    etude_EOYSale.desc      = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
    
    Promo *mandiri_discount = [Promo new];
    mandiri_discount.title = @"Mandiri Discount";
    mandiri_discount.brand     = @"Mandiri";
	mandiri_discount.brand_logo= @"mandiriDiscount.png";
	mandiri_discount.shop      = [NSArray arrayWithObjects:@"", nil];
    mandiri_discount.location  = [NSArray arrayWithObjects:@"", nil];
    mandiri_discount.poster_small= @"mandiriDiscount.png";
    mandiri_discount.poster_big  = @"";
    mandiri_discount.desc      = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";

    
    Promo *cinema21_promo = [Promo new];
    cinema21_promo.title = @"Cinema 21 Promo";
    cinema21_promo.brand     = @"Cinema 21";
    cinema21_promo.brand_logo= @"promo2.png";
	cinema21_promo.shop      = [NSArray arrayWithObjects:@"", nil];
    cinema21_promo.location  = [NSArray arrayWithObjects:@"", nil];
    cinema21_promo.poster_small= @"promo2.png";
    cinema21_promo.poster_big  = @"";
    cinema21_promo.desc      = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
    
    Promo *testing_promo = [Promo new];
    testing_promo.title = @"Testing Promo";
    testing_promo.brand     = @"GI";
    testing_promo.brand_logo= @"grand_indonesia.png";
	testing_promo.shop      = [NSArray arrayWithObjects:@"", nil];
    testing_promo.location  = [NSArray arrayWithObjects:@"", nil];
    testing_promo.poster_small= @"grand_indonesia.png";
    testing_promo.poster_big  = @"";
    testing_promo.desc      = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
    
    testing_promo = [Promo new];
    testing_promo.title = @"Testing Promo";
    testing_promo.brand     = @"GI";
    testing_promo.brand_logo= @"grand_indonesia.png";
    testing_promo.shop      = [NSArray arrayWithObjects:@"", nil];
    testing_promo.location  = [NSArray arrayWithObjects:@"", nil];
    testing_promo.poster_small= @"grand_indonesia.png";
    testing_promo.poster_big  = @"";
    testing_promo.desc      = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
    
    testing_promo = [Promo new];
    testing_promo.title = @"Testing Promo";
    testing_promo.brand     = @"GI";
    testing_promo.brand_logo= @"grand_indonesia.png";
    testing_promo.shop      = [NSArray arrayWithObjects:@"", nil];
    testing_promo.location  = [NSArray arrayWithObjects:@"", nil];
    testing_promo.poster_small= @"grand_indonesia.png";
    testing_promo.poster_big  = @"";
    testing_promo.desc      = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
    
    promos = [NSArray arrayWithObjects:etude_EOYSale,mandiri_discount,cinema21_promo, testing_promo, testing_promo, testing_promo, nil];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	if ([segue.identifier isEqualToString:@"showPromoDetail"]) {
		
		NSIndexPath *indexPath = nil;
		Promo *promo = nil;
		
		indexPath = [[self.collectionPromo indexPathsForSelectedItems]lastObject];
		promo = [promos objectAtIndex:indexPath.item];
		
		PromoDetailViewController *destViewController = segue.destinationViewController;
		destViewController.promo = promo;
	}
}

#pragma mark - Hide TabBar and NavBar

-(void)expand
{
	if(hidden)
		return;
	
	hidden = YES;
	
	[self.tabBarController setTabBarHidden:YES
								  animated:YES];
	
	[self.navigationController setNavigationBarHidden:YES
											 animated:YES];
	[[NSNotificationCenter defaultCenter]postNotificationName:@"expandState" object:self];
}

-(void)contract
{
	if(!hidden)
		return;
	
	hidden = NO;
	
	[self.tabBarController setTabBarHidden:NO
								  animated:YES];
	
	[self.navigationController setNavigationBarHidden:NO
											 animated:YES];
	[[NSNotificationCenter defaultCenter]postNotificationName:@"contractState" object:self];
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	startContentOffset = lastContentOffset = scrollView.contentOffset.y;
	//NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat currentOffset = scrollView.contentOffset.y;
	CGFloat differenceFromStart = startContentOffset - currentOffset;
	CGFloat differenceFromLast = lastContentOffset - currentOffset;
	lastContentOffset = currentOffset;
	
	
	
	if((differenceFromStart) < 0)
	{
		// scroll up
		if(scrollView.isTracking && (abs(differenceFromLast)>1))
			[self expand];
	}
	else {
		if(scrollView.isTracking && (abs(differenceFromLast)>1))
			[self contract];
	}
	
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
	[self contract];
	return YES;
}


@end
