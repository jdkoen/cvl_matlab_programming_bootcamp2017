# 1. GitHub Tutorial Links

[Using GitHub Desktop](https://programminghistorian.org/lessons/getting-started-with-github-desktop)

[GitHub Command Line](https://readwrite.com/2013/09/30/understanding-github-a-journey-for-beginners-part-1/)

[GitHub Control in Matlab!!!!](https://www.mathworks.com/help/matlab/matlab_prog/set-up-git-source-control.html?requestedDomain=www.mathworks.com)

# 2. Matlab Tutorial Links

[Data types in Matlab](https://www.mathworks.com/help/matlab/data-types_data-types.html)[ and a video](https://www.mathworks.com/videos/introducing-matlab-fundamental-classes-data-types-101503.html)

[Introduction to Cell and Structure Arrays](https://www.mathworks.com/videos/introducing-structures-and-cell-arrays-68992.html)

# 3. Variables in Matlab


## Numeric and String Variables

Variables in Matlab are defined in the following way:

```Matlab
myage = 33
myname = 'josh'
```

Variable names must begin with a character, and can have numbers and underscores after the first character.

```Matlab
myage2 = 25
myname_last = 'koen'
```

These variable names will not work (give them a try and read the error message):

```Matlab
25myage = 25;
myname last;
```

 When defining the above variables, Matlab will show the value assigned to each variable after typing it in the command window. This can be unwanted and rather annoying, particularly when running a script with many lines of code (and can actually slow down the script).  To suppress the output from the above commands, add a semi-colon at the end of the line. To see an example of how displaying the output can impact processing time, try the following lines of code:

```Matlab
% A % at the beginning of a line tells Matlab to ignore the following when parsing the code.
% This will use the tic() and toc() functions to compute time to make a matrix of random numbers.

% Suppress output and store computation time in t1
tic; rand(1000); t1=toc;

% Do not suppress output and store computation time in t2
tic; rand(1000), t2=toc;

% Compute difference between t2 and t1
t2 - t1;

% You probably didn't see anything come up. If you need to see the output, it is best to
% omit the semi-colon or store the value in a variable. Try this:
t2 - t1
tdiff = t2-t1;
tdiff % Calling a variable without
```

There are many different classes of variables in Matlab (see the link on Data types in Matlab). To find the class of a variable, simply use the `class` function

```Matlab
class(myage)
class(myname)
class(int32(myage))
```

## Logical variables

Many times in programming we want to know if an expression is true or false. This is done by using logical operations, which can also be stored in variables. Here are some examples:

```Matlab
5 > 2 % Greater than
4 >= 4 % Greater than or equal to
'a' < 'b' % Less than (and yes you can do this on strings)
int16(9) <= int16(8.9) % Less than or equal to
10 == 100 % Equal to
true ~= false % Does not equal
```

Logical expressions (that are scalar values) can be combined to meet multiple conditions at once. To do this, simply use `&&` or `||`, or to `xor` function:

```Matlab
5 < 7 && 7 > 4 % Should return true
5 < 4 || 9 > 1 % Should return true
xor(5 < 7,9 > 1) % Should return false
```

## Vectors and matrices

The variable types shown above are typically referred to as scalars (with the exception of the string variables). Scalars are a special case of vectors and matrices in that they only have one element. Vectors and matrices have more than one element. Here is a quick comparison with the variables (both numeric and character) that have been created so far:

```Matlab
size(myage)
size(myname)
```

The output will shown at minimum two values, where the first element is the number of rows (1st dimension), and the second element is the number of columns (2nd dimension).

It is important to understand how Matlab assigns elements in matrices and vectors. The following code will demonstrate this.

```Matlab
% Make a sequence of numbers
vec = 1:10

% Convert it to a matrix by reshaping the vector
mat = reshape(vec,2,5)

% How does reshape work? It first vectorizes input, and then assigns the elements of the vector to the
% new element structure of the different sized matrix.
mat2 = [1 3 5; 2 4 6];
vec2 = mat2(:);
mat3 = reshape(vec2,3,2);
mat4 = reshape(mat2,3,2);

% The constraint on using reshape is the numel(mat2) must equal the number of elements in the reshaped matrix (e.g., max(cumprod([3 2])))
numel(mat2) == max(cumprod([3 2]))
```

As you will see from the output, elements go by rows first (i.e., the 1st dimensions), the continue on the second dimension (columns). This will continue one until the length of the 2nd dimension is reached, and then would continue on to the third dimension (and so on), as in the following example:

```Matlab
vec3 = linspace(1,8,8);
mat_3d = reshape(vec3,[2 2 2])
```

Indexing variables is important in Matlab, as many times we only want to work on one element of a vector or matrix (I will just refer to both as a matrix from this point forward). There are two distinct ways of doing it. First, you can index using *element indexing*. Here is an example:

```Matlab
mat_3d(5) % This should return a value of 5
```

A second method of doing this is to index by the element along all dimensions. Here are two examples:

```Matlab
mat2 % Show the matrix
mat(1,2) % Grab the value of 3, or the 3rd element from mat2

mat_3d(1,1,2) % Grab the value of 5, or the fifth element from mat_3d
```

When indexing a variable, it is possible to select a subset of elements at a time. Here are examples of a few methods:

```Matlab
% Get the 1st and 3rd elements of mat 2, two ways
mat2([1 3])
mat2(1,1:2)
mat2(1,1:end-1)

% Make a 4-dimensional matrix, then select all elements in the 4th dimension as 1 element in the each of
% the first three dimensions
rng(10);
mat_4d = rand([50 50 50 10]);
vec_4d = mat_4d(2,2,2,:);
size(vec_4d) % What do you notice about this new "vector" that should be one dimensional?

% To make vec_4d a one dimensional variable, the squeeze function is useful, as it eliminates
% all dimensions with a length == 1
vec_4d = squeeze(vec_4d)
size(vec_4d) % this should return ans = [10 1]
```

Another, more flexible way of doing indexing is to do logical index. To do this, you must have a logical matrix that has the same number of elements as the matrix you are trying to pull data from. Let's us the mat_4d variable, and try to select all the values that are great than .5

```Matlab
% Make a logical matrix
is_above_point_five = mat_4d > .5; % Will this work on elements with multiple variables? Try and see

% Extract the numbers above .5 from mat_4d. What do you notice about the size of my_numbers?
my_numbers = mat_4d(is_above_point_five);
size(my_numbers)

% Now, let's add 10 to these numbers, and put them back in mat_4d
mat_4d_plus10 = zeros(size(mat_4d));
mat_4d_plus10(is_above_point_five) = my_numbers + 10;
mat_4d_plus10(~is_above_point_five) = mat_4d(~is_above_point_five);

% But wait, my_numbers is a vector. How do I know it went back into the right place.
% Let's check by replacing the numbers > 10 in mat_4d_plus10 with the original numbers, and compare the two matrices
mat_4d_plus10(is_above_point_five) = my_numbers;
isequal(mat_4d,mat_4d_plus10) % This should return a value of true, stating that mat_4d and mat_4d_plus10 have the same value in every elements
```

There are numerous ways to do logical indexing in Matlab, and many different is* functions to help. I would look these up yourselves.

Also, there are many intricacies of doing math with numeric matrices. I will not cover these in much detail, but here are some concepts you should know:
1. addition and subtraction of scalars, vectors, and matrices
2. scalar multiplication, matrix multiplication, and element-wise multiplication (this last one is useful more often then not, particularly if you are not doing linear algebra)
3. division (left vs. right)

## Cell Arrays (and Cell Arrays of Strings)

Matrices are nice variables for storing numeric data, but what if your data is text, as in a response someone gave, conditions identified as strings, etc. Character matrices can be used for this, but the are limited. Run the following code and try to figure out why there is an error on the `cmat2` variable but not `cmat1`.

```Matlab
cmat1 = ['Joshua'; 'Koen  ']
cmat2 = ['Joshua'; 'Koen']
```

If you have not figured it out, the error is caused by the string `'Koen'` having fewer elements than the string `'Joshua'`, that we are trying to vertically catenate. This illustrates an important rule of Matlab:

* Matrices, whether numeric or character, must have the same number of elements in ALL dimensions.

The reason `cmat1` works is because 2 spaces are added to the end of my last name (making both my first and last names have 6 elements). This is problematic for storing text/string data that has varying number of elements.

This is where cell arrays come into play (as well as cell arrays of strings). Cell arrays in Matlab allow you to store multiple types of data in a single variable. It can store strings, numeric scalars, vectors, matrices, numeric, data structures (that we will get to later), and so on. Importantly, each cell can have contents that differ in data type and number of elements. Let's make a cell array with demographic information about me. Note that cell arrays are created with `{}` instead of `()`.

```Matlab
% Try and figure out what the elispses (...) is for.
my_cell = { ...
  'Joshua'
  'Koen'
  'Postdoc'
  int16(33)
  [160 71 22.4]
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
