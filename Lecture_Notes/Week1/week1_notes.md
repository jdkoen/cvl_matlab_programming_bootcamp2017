# Overview

The goal is to develop basic programming skills in Matlab. Matlab is useful for numerous reasons:

1. Widely available
2. Excellent support
3. (Mainly) Open Source
4. Can do almost anything with it
5. Code is very reasonable

When developing code, it is necessary to have well documented code. Ideally, the code will be "versioned" with comments at to what changes were made. Old methods of this looked something like this (in a directory):

```
myscript_v1.m
myscript_v2.m
myscript_v3.m
...
myscript_v9_USED_THIS_FOR_PAPER.m
```

While the above works, it is not ideal. Hard to date-stamp multiple files, and revert back to older version. Also, what is the difference between `myscript_v9_USED_THIS_FOR_PAPER.m` and `myscript_v3.m`?

In Matlab, notes might have been added to the top of the file, and this can be helpful. For example, the first few lines of  `myscript_v9_USED_THIS_FOR_PAPER.m` might look like this:

```Matlab
% Fix misspelled phrase: 'Hello World' written as 'hlelo Wrodl'.
% (Other Changes)
```
