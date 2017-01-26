//
//  ViewController.m
//  Entrega4Chat
//
//  Created by dedam on 24/1/17.
//  Copyright © 2017 dedam. All rights reserved.
//

#import "ViewController.h"
#import "CellUserChat.h"
#import "ChatRoomVC.h"

@interface ViewController ()
{
    NSMutableArray* contactos;
    NSString *nom;
    UIImage *imagenView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    contactos = [[NSMutableArray alloc]init];
    [self initContactos];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"celdaSegue"]){
        ChatRoomVC *vc=[segue destinationViewController];
        vc.userChat=nom;
        vc.imageChat=imagenView;
    }
}

-(void)initContactos{
    [contactos addObject:[NSString stringWithFormat:@"Judit"]];
    [contactos addObject:[NSString stringWithFormat:@"Sara"]];
    [contactos addObject:[NSString stringWithFormat:@"Luis Enrique"]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return contactos.count;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    nom=[contactos objectAtIndex:indexPath.row];
    imagenView=[UIImage imageNamed:@"company.png"];
    [self performSegueWithIdentifier:@"celdaSegue" sender:nil];
    return indexPath;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellUserChat";
    CellUserChat *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[CellUserChat alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.userChat.text = contactos[indexPath.row];
   
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
