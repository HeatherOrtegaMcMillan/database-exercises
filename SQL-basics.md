# SQL PRO 
## Keyboard Shortcuts
- to Run current Query Command ⌘ R
- Run All Queries Option ⌥ Command ⌘ R
- the button for this is middle right (also lists keyboard shortcuts)
- [Here's a link to all the keyboard shortcuts](https://sequelpro.com/docs/get-started/keyboard-shortcuts)

## Syntax Notes
- Be sure to end every line with a ;
- Just like C
- MySQL commands are case insensitive
- COMMENT YOUR CODE! use `--` or `/* blah blah blah */` for multi line comments

## Databaes and Tables
- Databases are the parents
- Databaeses live on servers
- Data lives on Tables inside the Databases
- Can have many tables inside one database
- Tables = HONKIN' Spreadsheets
- to show current db `SELECT database();`

## Where Clause
- ORDER OF OPERATIONS IS SUPER IMPORTANT!! 
1. NOT
2. AND
3. OR
- LIKE uses one thing
- IN uses a list of things


## Data Types
- [Different INT Type Sizes](https://dev.mysql.com/doc/refman/5.7/en/integer-types.html)
- Be mindful about the size and type that you use
- [Numeric Types](https://ds.codeup.com/sql/tables/#numeric-types)
- [String Types](https://ds.codeup.com/sql/tables/#string-types)
- [Date Types](https://ds.codeup.com/sql/tables/#date-types)
- NULL means there's nothing here. not 0. nothing is there
- can allow NULLs, can prohibit them
    - if verboten, you'll get an error
    - allowing NULLs will give you holes in your data

## Limits and Offset
- LIMIT will only return the first x number
- OFFSET x will start on the x+1 number
- Always last instruction in the query
- use ORDER BY to get different sets
