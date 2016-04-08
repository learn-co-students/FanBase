//
//  FNBEventInfoVC.m
//  FanBase
//
//  Created by Angelica Bato on 4/7/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import "FNBEventInfoVC.h"

@interface FNBEventInfoVC ()

@property (strong, nonatomic) IBOutlet MKMapView *eventMapView;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventVenue;
@property (strong, nonatomic) IBOutlet UILabel *eventDate;
@property (strong, nonatomic) IBOutlet UILabel *ticketsAvailable;
@property (strong, nonatomic) IBOutlet UIImageView *artistImage;


@end

@implementation FNBEventInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationDegrees latitude = [self.event.venue[@"latitude"] doubleValue];
    CLLocationDegrees longitude = [self.event.venue[@"longitude"] doubleValue];
    CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(latitude, longitude);
    
    CLLocationDistance regionRadius = 1000;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location2, (regionRadius*2.0), (regionRadius*2.0));
    
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    [annot setCoordinate:location2];
    
    [self.eventMapView setCenterCoordinate:location2 animated:YES];
    [self.eventMapView setRegion:region animated:YES];
    [self.eventMapView addAnnotation:annot];
    
    
    self.eventTitle.text = self.event.eventTitle;
    self.eventVenue.text = self.event.venue[@"name"];
    self.eventDate.text = self.event.dateOfConcert;
    if (self.event.isTicketsAvailable == YES) {
        self.ticketsAvailable.text = @"Ticket Available: YES";
    }
    else {
        self.ticketsAvailable.text = @"Ticket Available: NO";
    }
    
    
    NSURL *picURL = [NSURL URLWithString:self.event.artistImageURL];
    [self.artistImage setImageWithURL:picURL];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
