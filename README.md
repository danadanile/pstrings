# pstrings
In this program, the user inputs two pstrings, each consisting of a length and corresponding text, along with an option. Based on the selected option, specific actions are performed, and the result is displayed on the console.
## General
The main_run function takes two strings, their respective lengths, and a menu option as input from the user. It creates two pstrings based on the provided strings and lengths, then passes the menu option and the addresses of the pstrings to the func_run function.

The menu options and corresponding actions are as follows:

Option 31:

Use the pstrlen function to calculate and display the lengths of both pstrings.

Option 32/33:

The user provides two characters: oldChar (to be replaced) and newChar (replacement character). The replaceChar function is used to replace all occurrences of oldChar with newChar in both pstrings. After the replacement, the updated pstrings are printed.

Option 35:

The user inputs two numbers: a start index and an end index. These are passed to the pstrijcpy function, which copies the substring from the second pstring (source) to the first pstring (destination), based on the given indices. After copying, both pstrings are printed.

Option 36:

The swapCase function is called to swap the case of each letter in both pstrings. Uppercase letters (A-Z) are converted to lowercase (a-z) and vice versa. The modified pstrings are then printed.

Option 37:

The user inputs a start index and an end index. The pstrijcmp function is called to compare the substrings in the specified index range of both pstrings. The result of the comparison is printed.

Invalid Option:

If an unrecognized option is provided, the program prints: "Invalid option!" and exits.

After each operation, the program terminates gracefully.

## Instalation
Before setting up this project, ensure the following are installed on your computer:

Git
Make
NASM (Netwide Assembler) or another assembler for compiling assembly files

Once these tools are installed, follow these steps in the terminal:
```
git clone https://github.com/danadanile/pstrings.git
make clean
make
./a.out
```

## Author:
Dana Danilenko

Year Created: 2022

