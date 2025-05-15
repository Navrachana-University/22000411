README.txt
==========

Project Title: Custom Java-like Compiler with Three Address Code (TAC) Generation

Description:
------------
This project implements a simplified Java-like compiler using Flex (Lex) and Bison (Yacc) tools. 
The compiler supports custom keywords and syntax for basic Java constructs like variable declarations, 
arithmetic expressions, conditional statements, loops (if, while, for), print statements, and return statements.

As input, it accepts code written using modified keywords such as:
- 'blueprint' instead of 'class'
- 'when' instead of 'if'
- 'during' instead of 'while/for'
- 'giveback' instead of 'return'
- 'show' instead of 'System.out.println'
and more.

The output generated is in the form of intermediate Three Address Code (TAC), which is useful for understanding the backend of a compiler.

Authors:
--------
Keyur Arora      | Enrollment ID: 22000390  
Rishabh Pawar    | Enrollment ID: 22000411  

Instructions to Compile and Run:
--------------------------------
1. Make sure Flex, Bison, and GCC are installed on your system.
2. Open a terminal in the project directory and run the following commands:

   flex custom_java.l  
   bison -d custom_java.y  
   gcc lex.yy.c custom_java.tab.c -o custom_java.exe  

3. Three sample input files (`input.java`, `input1.java`, `input2.java`) are provided in the repository.
   You can test the compiler using any of them:

   Example:
   ./custom_java.exe < input.java

4. The Three Address Code (TAC) will be printed on the terminal.


