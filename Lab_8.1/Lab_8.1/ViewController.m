//
//  ViewController.m
//  Lab_8.1
//
//  Created by Admin on 07.06.17.
//  Copyright © 2017 Oleg Kiselevich. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "FlightsTableViewController.h"

@interface ViewController ()
{
    int isCity;
    
    MKPointAnnotation *annotatiionFrom;
    MKPointAnnotation *annotatiionTo;
    NSManagedObjectContext *context;
}

@property (strong, nonatomic) IBOutlet UITextField *cityFromTF;
@property (strong, nonatomic) IBOutlet UITextField *cityToTF;
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic) NSMutableArray *flights;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
    UILongPressGestureRecognizer *longPressGesture =
    
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    
    [self.map addGestureRecognizer:longPressGesture];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:context];
    NSManagedObject *recordFirst = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    [recordFirst setValue:@"Minsk" forKey:@"cityFrom"];
    [recordFirst setValue:@"Brest" forKey:@"cityTo"];
    [recordFirst setValue:@"Belavia" forKey:@"aviaCompany"];
    [recordFirst setValue:[NSNumber numberWithFloat:1000.0] forKey:@"price"];
    
    NSError *error;
    [context save:&error];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)isFrom:(id)sender
{
    isCity = 0;
}

- (IBAction)isTo:(id)sender
{
    isCity=1;
}

- (IBAction)showFlights:(id)sender
{
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"cityFrom like %@ and cityTo like %@",self.cityFrom.text,self.cityTo.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:@"Information not found"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK",nil];
        [alert show];

    }
    else
    {
        NSString *cityFrom;
        NSString *cityTo;
        NSString *aviaCompany;
        NSString *price;
        
        for(NSManagedObject *obj in matchingData)
        {
            cityFrom = [obj valueForKey:@"cityFrom"];
            cityTo = [obj valueForKey:@"cityTo"];
            aviaCompany = [obj valueForKey:@"aviaCompany"];
            price = [obj valueForKey:@"price"];
        }
        NSString *show = [NSString stringWithFormat:@"From:%@\nTo:%@\nAviaCompany:%@\nPrice:%@", cityFrom, cityTo,aviaCompany,price];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:show
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK",nil];
        [alert show];
       // [alert release];
    }
    /*FlightsTableViewController *flightsVC = [[FlightsTableViewController alloc] initWithCities:self.cityFrom.text cityTo:self.cityTo.text];
    
     [[self navigationController] pushViewController:flightsVC animated:YES];*/
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.map];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        CLLocationCoordinate2D coord = [self.map convertPoint:point
                                         toCoordinateFromView:self.map];
        CLLocation *location = [[CLLocation alloc]
                                initWithLatitude:coord.latitude longitude:coord.longitude];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Geocode failed with error: %@", error);
                 return;
             }
             for (CLPlacemark * placemark in placemarks) {
                 [self setAnnotationToMap:isCity :placemark.locality
                                         :coord];
             }
         }];
    }
}

-(void)setAnnotationToMap:(int)type :(NSString *)title
                         :(CLLocationCoordinate2D)coordinate
{
    if (type == 0) {
        [_map removeAnnotation:annotatiionFrom];
        annotatiionFrom = [[MKPointAnnotation alloc] init];
        annotatiionFrom.title = title;
        annotatiionFrom.coordinate = coordinate;
        [_map addAnnotation:annotatiionFrom];
        self.cityFrom.text = title;
    }
    else
    {
        [_map removeAnnotation:annotatiionTo];
        annotatiionTo = [[MKPointAnnotation alloc] init];
        annotatiionTo.title = title;
        annotatiionTo.coordinate = coordinate;
        [_map addAnnotation:annotatiionTo];
        self.cityTo.text = title;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.cityFrom)
        isCity = 0;
    else if (textField == self.cityTo)
        isCity = 1;
    [textField resignFirstResponder];
}


@end
