//
//  RFTableAdapter.m
//  RACFrame
//
//  Created by  rjt on 17/2/17.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFTableAdapter.h"
#import "RFSectionBox.h"
#import "RFSplitEntity.h"

@interface RFTableAdapter ()
@property (strong, nonatomic) NSMutableArray<RFSectionBox*> *records;
@property (strong, nonatomic) NSMutableArray<NSObject*> *entities;
@property (strong, nonatomic) RACSubject *unbindSignal;
@property (strong, nonatomic) NSArray<NSString*> *nibArray;
@property (strong, nonatomic) NSMutableDictionary<NSString*,UIView*> *sectionDict;
@property (weak,nonatomic) UITableView* table;
@property (weak,nonatomic) id<RFTableDelegate> controller;
@end

@implementation RFTableAdapter

#pragma mark - init methods
+(instancetype)adapterWithTable:(UITableView *)table andController:(id<RFTableDelegate>)controller andNibArray:(NSArray<NSString *> *)nibArray{
    RFTableAdapter *a = [[RFTableAdapter alloc] initWithTable:table andController:controller andNibArray:nibArray];
    return a;
}
-(instancetype)initWithTable:(UITableView *)table andController:(id<RFTableDelegate>)controller andNibArray:(NSArray<NSString *> *)nibArray{
    if(self = [super init]){
        _records = [NSMutableArray<RFSectionBox*> array];
        _entities = [NSMutableArray<NSObject*> array];
        _table = table;
        _table.delegate = self;
        _table.dataSource = self;
        //没有分割线
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _controller = controller;
        _nibArray = [NSArray arrayWithArray:nibArray];
        _sectionDict = [NSMutableDictionary dictionary];
        _unbindSignal = [RACSubject subject];
    }
    return self;
}
#pragma mark - extends methods

#pragma mark - public methods
-(void)addEntity:(id)entity withSection:(Class)clss{
    UIView* v = [self.sectionDict objectForKey:[clss description]];
    if(!v){
        v = [RFNibHelper loadNibArray:self.nibArray ofClass:clss];
        [self.sectionDict setObject:v forKey:[clss description]];
    }
    [_records addObject:[RFSectionBox boxWithEntity:entity andSectionClass:clss andSectionHeight:v.bounds.size.height]];
}

-(void)addEntities:(NSArray*)entities withSection:(Class)clss{
    for(id e in entities){
        [self addEntity:e withSection:clss];
    }
}


-(void)addSplitWithColor:(UIColor*)color{
    [self addSplitWithColor:color andHeight:kSplitSectionHeight];
}

-(void)addSplitWithColor:(UIColor*)color andHeight:(float)height{
    UIView* v = [self.sectionDict objectForKey:[[RFSplitSection class] description]];
    if(!v){
        v = [RFSplitSection new];
        [self.sectionDict setObject:v forKey:[[RFSplitSection class] description]];
    }
    RFSplitEntity *entity = [RFSplitEntity new];
    entity.bgColor = color;
    entity.sectionHeight = height;
    [_records addObject:[RFSectionBox boxWithEntity:entity andSectionClass:[RFSplitSection class] andSectionHeight:height]];
}

-(void)removeAll{
    [_records removeAllObjects];
    [_entities removeAllObjects];
}


#pragma mark - private methods

#pragma mark - delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RFSectionBox *box = _records[indexPath.row];
    id et = box.entity;
    NSString* sectionClassName=[box.sectionClss description];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionClassName];
    if (cell == nil) {
        Class cls=box.sectionClss;
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionClassName];
        
        UIView* section;
        
        /** 如果实现了自定义Section初始化委托，用于notifyChangeForSection 时，复用现有Section */
        if([self.controller respondsToSelector:@selector(rftable:initSectionClass:)]){
            section= [self.controller rftable:self.table initSectionClass:cls];
        }
        
        if(!section){
            section= [RFNibHelper loadNibArray:self.nibArray ofClass:cls];
        }
        if(!section){
            section = [[cls alloc] init];
        }
        bool isRFSection = [section conformsToProtocol:@protocol(IRFSection)];
        
        if(isRFSection && [section respondsToSelector:@selector(sectionWillDidLoad)]){
            [(id<IRFSection>)section sectionWillDidLoad]; // 初始化Section 数据
        }
        
        /** 初始化构造Section时调用 */
        if([self.controller respondsToSelector:@selector(rftable:willLoadSection:entity:)]){
            [self.controller rftable:self.table willLoadSection:section entity:et];
        }
        
        [cell.contentView addSubview:section];
        
        if(isRFSection && [section respondsToSelector:@selector(sectionDidLoadWithEntity:andCell:)]){
            [(id<IRFSection>)section sectionDidLoadWithEntity:et andCell:cell]; // 初始化Section 数据
        }
        
        NSLayoutConstraint *widthLayout = [NSLayoutConstraint constraintWithItem:section attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        NSLayoutConstraint *hightLayout = [NSLayoutConstraint constraintWithItem:section attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
        NSLayoutConstraint *leftLayout = [NSLayoutConstraint constraintWithItem:section attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *topLayout = [NSLayoutConstraint constraintWithItem:section attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1 constant:0];


        [section setTranslatesAutoresizingMaskIntoConstraints:NO];
        [cell addConstraint:widthLayout];
        [cell addConstraint:hightLayout];
        [cell addConstraint:leftLayout];
        [cell addConstraint:topLayout];
        
        cell.clipsToBounds = YES;
//        CGRect rect = section.frame;
//        rect.size.width = cell.frame.size.width;
//        NSLog(@"rect.size.width = %d",rect.size.width);
//        section.frame = rect;
        

        //点击cell不变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    UIView* section = [cell.contentView subviews][0];
    
    box.section = section;

    if([self.controller respondsToSelector:@selector(rftable:forSection:entity:)]){
        [self.controller rftable:self.table forSection:section entity:et];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RFSectionBox *box = _records[indexPath.row];
    if([self.controller respondsToSelector:@selector(rftable:selectedSection:entity:)]){
        [self.controller rftable:self.table selectedSection:box.section entity:box.entity];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger height = _records[indexPath.row].section.frame.size.height;
    return height>0?height:_records[indexPath.row].sectionHeight;

}
#pragma mark - Action methods

#pragma mark - get/set methods

@end
