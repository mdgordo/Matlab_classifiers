%% Attempts to train a model using treetrain on the Titanic dataset

%read data
train_data = readtable('train.csv');
%how to drop bad columns
train_data(:,{'Cabin','Name'}) = [];
%drop rows
train_data = rmmissing(train_data);
% if you wanted to iterate and choose which columns to drop over...
%for i = 1:size(train_data,2)
%    train_data(ismissing(train_data(:,i)),:) = [];
%end

%fix genders
Sex = 0+strcmp(table2cell(train_data(:,'Sex')),'female');
train_data(:,{'Sex'}) = [];
train_data = [train_data, table(Sex)];

%fix embarkment
Q = strcmp(table2cell(train_data(:,'Embarked')),'Q');
C = strcmp(table2cell(train_data(:,'Embarked')),'C');
Embarked = zeros(size(train_data,1),1);
Embarked(Q) = 1;
Embarked(C) = 2; 
train_data(:,{'Embarked'}) = [];
train_data = [train_data, table(Embarked)];

% fix ticket names
Ticketi=double(char(train_data.Ticket));
Ticketi=Ticketi(:,1);
Ticket=ones(size(train_data,1),1);
Ticket(Ticketi>49&Ticketi<59)=2;
Ticket(Ticketi>=60&Ticketi<69)=3;
Ticket(Ticketi>=70&Ticketi<79)=4;
Ticket(Ticketi>=80)=5;

train_data(:,{'Ticket'})=[];
train_data = [train_data, table(Ticket)];

%bin the ages by prctile
Age = zeros(size(train_data,1),1);
Age(train_data.Age>prctile(train_data.Age,25)) = 1;
Age(train_data.Age>prctile(train_data.Age,50)) = 2;
Age(train_data.Age>prctile(train_data.Age,75)) = 3;

train_data(:,{'Age'})=[];
train_data = [train_data, table(Age)];


%bin the fares by prctile
Fare = zeros(size(train_data,1),1);
Fare(train_data.Fare>prctile(train_data.Fare,25)) = 1;
Fare(train_data.Fare>prctile(train_data.Fare,50)) = 2;
Fare(train_data.Fare>prctile(train_data.Fare,75)) = 3;

train_data(:,{'Fare'})=[];
train_data = [train_data, table(Fare)];

%% add one to all variables that start at zero
train_datamat=table2array(train_data)
for i=1:size(train_datamat,2)
    if min(train_datamat(:,i))==0
        train_datamat(:,i)=ones(size(train_datamat,1),1)+train_datamat(:,i)
    else
    end
end


%% set up for titanic dataset
c=train_datamat(:,2)
nc=2
x=train_datamat(:,3:10)
nx=max(x)

tr=treetrain(c,nc,x,nx)






