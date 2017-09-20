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

Logical expressions can be combined to meet multiple conditions at once. To do this, simply use `&&` or `||`, or to `xor` function: 


## Generating Random numbers

Matlab has many
