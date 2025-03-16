//
//  TheaterDateView.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterDateView.h"
#import "TheaterDateItemModel.h"
#import "TheaterResultViewModel.h"

@interface TheaterDateView () <UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, weak) id<DateViewProtocol> delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *transparentView;
/// viewModel
@property (strong, nonatomic) TheaterResultViewModel *viewModel;

/// Disposable数组
@property (strong, nonatomic) NSMutableArray<RACDisposable *> *disposees;

@end

@implementation TheaterDateView

+ (instancetype)bindViewWithViewModel:(id)viewModel {
    TheaterDateView *view = [[self alloc] init];
    view.viewModel = viewModel;
    [view configViewModel];
    return view;
}

- (void)configViewModel {
    
    @weakify(self);
    
    // 监听banner
    [self.disposees addObject:
     self.viewModel.refreshSignal(@"TheaterDateView").deliverOnMainThread.subscribeNext(^(NSNumber *value) {
        @strongify(self);
        
        self.dateButton.userInteractionEnabled = YES;
        [self.dateButton setTitle:self.viewModel.listData[0].date forState:UIControlStateNormal];
        [self.tableView reloadData];
    })];
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dateButton];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
}

- (UIButton *)dateButton {
    if (!_dateButton) {
        _dateButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 40)];
        [_dateButton setTitle:@"暫時無資訊" forState:UIControlStateNormal];
        _dateButton.userInteractionEnabled = NO;
        [_dateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _dateButton.enabled = YES;
        _dateButton.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:138.0/255.0 blue:138.0/255.0 alpha:1];
        [_dateButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateButton;
}

- (void)click:(id)sender {
    
    [self addTransparentViewWithFrame:self.dateButton.frame];
    [self.delegate SetDateViewHeight:SCREEN_HEIGHT];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UIView *)transparentView {
    if (!_transparentView) {
        UIWindow *foundWindow = nil;
        NSArray *scenes=[[[UIApplication sharedApplication] connectedScenes] allObjects];
        NSArray *windows=[[scenes objectAtIndex:0] windows];
        for (UIWindow  *window in windows) {
            if (window.isKeyWindow) {
                foundWindow = window;
                break;
            }
        }
        _transparentView = [[UIView alloc] initWithFrame:foundWindow.frame];
    }
    return _transparentView;
}

- (void)addTransparentViewWithFrame:(CGRect)frame {
    
    [self addSubview:self.transparentView];
    self.tableView.frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, 0);
    [self addSubview:self.tableView];
    self.tableView.layer.cornerRadius = 5;
    
    self.transparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    [self.tableView reloadData];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTransparentView)];
    [self.transparentView addGestureRecognizer:tapGesture];
    self.transparentView.alpha = 0;
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transparentView.alpha = 0.5;
        self.tableView.frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + 5, frame.size.width, self.viewModel.listData.count * 50);
    } completion:nil];
}

- (void)removeTransparentView {
    CGRect frame = self.dateButton.frame;
    [self.delegate SetDateViewHeight:60];
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transparentView.alpha = 0;
        self.tableView.frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, 0);
    } completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue: 213/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    cell.textLabel.text = self.viewModel.listData[indexPath.row].date;
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dateButton setTitle:self.viewModel.listData[indexPath.row].date forState:UIControlStateNormal];
    [self.delegate SetSelectRow:indexPath.row];
    [self removeTransparentView];
}

- (NSMutableArray<RACDisposable *> *)disposees{
    return HT_LAZY(_disposees, @[].mutableCopy);
}
- (void)dealloc{
    [self.disposees makeObjectsPerformSelector:@selector(dispose)];
}

@end
