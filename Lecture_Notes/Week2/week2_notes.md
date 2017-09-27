## Cell Arrays (and Cell Arrays of Strings)

Matrices are nice variables for storing numeric data, but what if your data is text, as in a response someone gave, conditions identified as strings, etc? Character matrices can be used for this, but the are limited. Run the following code and try to figure out why there is an error making the `cmat2` variable but not `cmat1`.

```Matlab
cmat1 = ['Joshua'; 'Koen  ']
cmat2 = ['Joshua'; 'Koen']
```

If you have not figured it out, the error is caused by the string `'Koen'` having fewer elements than the string `'Joshua'`, that we are trying to vertically concatenate. This illustrates an important rule of Matlab:

* Matrices, whether numeric or character, must have the same number of elements in ALL dimensions.

The reason `cmat1` works is because 2 spaces are added to the end of my last name (making both my first and last names have 6 elements). This is problematic for storing text/string data that has varying number of elements.

This is where cell arrays can be very useful (as well as cell arrays of strings). Cell arrays in Matlab allow you to store multiple types of data in a single variable, and cell arrays can store strings, numeric scalars, vectors, matrices, numeric, data structures (that we will get to later), and so on. Importantly, each cell can have contents that differ in data type and number of elements. Let's make a cell array with demographic information about me. Note that cell arrays are created with `{}` instead of `()`.

```Matlab
% Try and figure out what the elispses (...) are for.
my_cell = { ...
  'Joshua'
  'Koen'
  'Postdoc'
  33
  .3
}
```

Indexing in cell arrays takes two forms. Let's look at the difference first with code:

```Matlab
my_cell(1)
type(ans)
my_cell{1}
type(ans)
```

Notice the difference? `my_cell(1)` returns a value of type cell whereas `my_cell{1}` returns a character array. This is the difference between *cell indexing* and *content indexing*. This can get tricky to think about (and ccan be tricky to remember), so let's think about it using an analogy where the cell array is like the presents under a Christmas tree. *Cell indexing*, when you use the `()`, is like getting one of your presents from the tree but not opening it (you know, that part we all dislike about Christmas - having all the presents but waiting to open them). In contrast, *content indexing*, when you use the `{}`, is like grabbing the presented, tearing off the wrapping, and viewing the amazing bag of socks a family member bought for you. When working with cell arrays, it is important to know HOW and WHEN to use the different types of indexing, because it can make a big difference in how data are processed.

Let's look at a cell array. Load the `cData` variable into your workspace:
```Matlab
load('week2_data_file.mat','cData') % Adding just the file will load ALL variables into the workspace, whereas inputs after the file name will load just the specified variable(s).
cData(1:5,:) % Look at the first five rows of the data
```

This is a cell array of data from a simulated recognition memory experiment. The rows represent individual trials and columns represent different attributes of the file. This data format is useful, and is similar to many 'standard' ways of coding/analyzing data (e.g., Excel spreadsheets).

Can you think of any potential problems with analyzing/coding this data?

We will work more with this variable (i.e., cData) when going over selection statements.

## Structure Arrays

Structure arrays in Matlab are a nice better alternative that using cell arrays for data storage. (In my opinion, structure arrays are better in most situations compared to cell arrays, but there are times when cell arrays are preferable). These have the advantage of assigning more 'descriptive' labels to variables, as you will see below.

```Matlab
my_cell = horzcat(my_cell,{'Chris';'Foster';'Postdoc';int16(32);0})
```

Let's use the `my_cell` cell array defined above. Let's just say, for example, this cell array is storing demographic data such as first and last name, occupation, age, and uncorrected visual acuity along the row dimension (e.g., `my_cell{2,1}` will return my last name.

If this contained a large amount of personal data (more rows) for many different people (more columns) this cell array can easily become difficult to work with. Having to remember what row a specific variable becomes difficult. There are two ways to use structures with this.

One is to use a structure variable to store row labels. Try the code and see how structure variables can be used to store row (or column) labels:

```Matlab
rowLabels = struct('first_name',1,'last_name',2,'occupation',3,'age',4,'visual_acuity',5);
rowLabels % Display the data structure
my_cell(rowLabels.occupation,:) % Return all peopls occupation
```

This is using a structure variable as a sort of indexer. Another approach is to use an arrayed structure (i.e., a structure with more than one element) to store data. Make a new structure with same information as column 1 of `my_cell`:

```Matlab
my_struct.first_name = 'Joshua';
my_struct.last_name = 'Koen';
my_struct.occupation = 'Postdoc';
my_struct.age = 33;
my_struct.visual_acuity = .3
```
If we want my occupation, we simply type `my_struct.occupation`, which is easier to read in my opinion than `my_cell{rowLabels.occupation,1}`. Right now, this only has one person's data in, so how do we make this into an array? Here are two ways

```Matlab
% This will work
my_struct(2).first_name = 'Chris';
my_struct(2).last_name = 'Foster';
my_struct(2).occupation = 'Postdoc';
my_struct(2).age = 32;
my_struct(2).visual_acuity = 0;

% This will too, and it is more efficient
my_struct(2) = cell2struct(my_cell(:,2),fieldnames(rowLabels));

% If you have a cell array data format, the cell array can be converted to a structure array using the cell2struct() function
new_struct = cell2struct(my_cell,fieldnames(rowLabels));

% Compare to my_struct to show it is doing the same thing.
isequal(my_struct,new_struct') % I use ' to transpose new_struct has cell2struct output as a column vector but my_struct is a row vector
```

Can you think of any potential downfalls of working with this type of data structure?

## Selection statements

### If, Else If Statements

One of the most common logical programming states is the if-else if statement. The general idea with these statements are to do something if a condition is true, and do something else if a different condition is true. Let's take a simple input command to show how this works. Run the following code:

```Matlab
myResp = input('Type a single-digit number, then press enter: ');
if ismember(myResp,0:4)
  fprintf('You entered a number between 0 and 4.\n')
else
  fprintf('You entered a number that is not between 0 and 4.\n')
end
```

If you enter a number between 0 and 4, you should see `You entered a number between 0 and 4.` display in your command window. Otherwise, you will see `You entered a number that is not between 0 and 4.`. This last text will occur if you enter ANY number outside the range 0 and 4. Try the above code again two times, once using a negative number and once using a 2-digit number to check for yourself. What can be gleaned from this is that the commands following `else` will be executed if NONE of the `if` and `elseif` conditional statements are true.  

Imagine you were trying to collect behavioral responses for a task, and only wanted participants to use a set amount of keys. But what if you only wanted a single-digit response (one between 0 and 9). You can modify the above code to throw an error if anything other than a 0 to 9 value is given:

```Matlab
myResp = input('Type a single-digit number, then press enter: ');
if ismember(myResp,0:4)
  fprintf('You entered a number between 0 and 4.\n')
elseif ismember(myResp,5:9)
  fprintf('You entered a number between 5 and 9.\n')
else
  error('You entered a number that is not between 0 and 9. This is an error.')
end
```

Let's change the above code to tell us if we entered an odd or even single-digit number. Think about how you might change this to work with any integer value.

```Matlab
myResp = input('Type a single-digit number between 1 and 9, then press enter: ');
if ismember(myResp,1:2:9)
  fprintf('You entered a odd number.\n')
elseif ismember(myResp,2:2:9)
  fprintf('You entered a even number.\n')
else
  error('You entered a number that is not between 1 and 9. This is an error.')
end
```

There are some important points to consider about `if` statements:
1. The conditional statement must return a SCALAR LOGICAL variable (use either `&&`, `||`, `any`, or `all` when combining logical vectors).
2. The conditional statements are evaluated in a SEQUENTIAL fashion.
3. The `else` statement is a catch all where any code after it is run when NONE of the conditional statements prior to it are met.
4. An `else` statement is not necessary, but if none of the conditional statements are met nothing happens.
5. Must close all if statements with an `end` command.

### For Loops

For loops are a staple in many programming languages as they allow us to iterate across elements and apply a series of commands to each element. For loops allow iterations over a finite set of elements (i.e., they cannot be infinite for loops). Here, we will start to work with the `cData` variable. For the rest of these notes, I would like you to try and modify the code yourself to make it work with a structure variable.

First, let's use a for loop to spit out the trials of our data.

```Matlab
% Make a dataCols struct to label cData columns
dataCols = struct('trial_num',1,'item_type',2,'resp',3,'rt',4);

% Remove the header column from cData
cData(1,:) = []; % For a cell or matrix, using the () indexing and setting equal to [] will remove an element. You can only remove rows and columns as a whole, not single elements (unless you have a vector)

% Show the data for the first 20 trials
for i = 1:20
  fprintf('%d\t\t%s\t\t%d\t\t%1.3f\n',cData{i,:});
end
```

Briefly, the above for loop grabs one row of data, and displays it to the command window using `fprintf`.

`cData` contains data from a simulated recognition memory task whereby someone studied a list of words, and were asked to respond at test whether a word was previously studied (a 'old' response) or not (a 'new' response). The item_type column (column 2) reflects actual status of an item (whether it was old or new), the resp column (column 3) is the test response (1=old response, 2=new response), and the last column is the reaction time (RT) to make the response. Let's code this such that we label trials according to the following classifications:

* 1 = hit = old item given a 'old' response
* 2 = miss = old item given a 'new' response
* 3 = fa = new item given a 'old' response (false alarm)
* 4 = cr = new item given a 'new' response (correct rejection)

The aim is to assign the strings 'hit', 'miss', 'fa', and 'cr' to a new column in cData. To do this use a `for` loop with `if` and `elseif` statements:

```Matlab
% Add the number column first
cData(:,end+1) = cell(size(cData,1),1);

% Add a field to dataCols
dataCols.coded_resp = 5;

% Iterate over all rows, and determine how to fill column 5 for row i. Let's also time it
tic;
for i = 1:size(cData,1) % Read the number of rows from cData, and make a vector from 1:nRows

  % Since you will use the same value of cData in 4 different conditional statements, pull them out to separate variables
  % Remember to use content indexing
  itemType = cData{i,dataCols.item_type};
  resp = cData{i,dataCols.resp};
  thisCode = ''; % Initialize thisCode as an empty string

  % Evaluate the if-elseif statements
  if strcmpi(itemType,'old') && resp == 1 % For a old item given a 'old' response

    thisCode = 1;

  elseif strcmpi(itemType,'old') && resp == 2 % For a old item given a 'new' response

      thisCode = 2;

  elseif strcmpi(itemType,'new') && resp == 1 % For a new item given a 'old' response

    thisCode = 3;

  elseif strcmpi(itemType,'new') && resp == 2 % For a new item given a 'new' response

      thisCode = 4;

  else

    warning('Trial # %d could not be coded. Entering NA for coding.')
    thisCode = 'NA';

  end

end
forTOC = toc;
```

Do you need a `for` loop for this? Remember, there are always many different ways to accomplish the same task. Here is a different (and more complicated to read) way to do this.

```Matlab
% Remove and replace column 5 with blank values
cData(:,end) = cell(size(cData,1),1);

% Add coding using logical indexing and assignment
itemTypes = cData(:,dataCols.item_type);
resps = cell2mat(cData(:,dataCols.resp));
cData(strcmpi(itemTypes,'old') & resps == 1,dataCols.coded_resp) = {1};
cData(strcmpi(itemTypes,'old') & resps == 2,dataCols.coded_resp) = {2};
cData(strcmpi(itemTypes,'new') & resps == 1,dataCols.coded_resp) = {3};
cData(strcmpi(itemTypes,'new') & resps == 2,dataCols.coded_resp) = {4};
```
