## CS753 Assignment 1 [Problem 3]

### Directory Structure

#### ./create-dict-files
- Contains .sh and .py files
- .py files are used to create text specification files that are used for creation of binary files by .sh files.
- .sh files call the .py files to create FST specification files and use those to output FST binaries
- more details are in subsequent subproblem descriptions

#### ./fst-files
- Contains final .fst binaries constructed by the .sh files in ./create-dict-files

#### ./lex-files
- Contains the specification files for FSTs which are used by .sh files in ./create-dict-files to create FST Binaries

#### ./lookup-files
- Contains files that traverse through FST files and print output on the terminal

#### ./text-files
- Contains text files that provide pronunciation mappings for words

### Problem 3.1 : Dictionary FST, L

#### Files Required
1. ./create-dict-files/create-dict.sh (Coded)
2. ./create-dict-files/create-dict.py (Coded)
3. ./lookup-files/lookup-1.sh (Coded)
4. ./lookup-files/printfst.py (Coded)
5. ./text-files/lex.txt (Given)
6. ./fst-files/L.fst (Generated)

#### Usage
``
- $ chmod 777 ./create-dict-files/create-dict.sh
- $ chmod 777 ./lookup-files/lookup-1.sh
- $ ./create-dict-files/create-dict.sh lex.txt > fst-files/L.fst
- $ ./lookup-files/lookup-1.sh L.fst in.txt ALICE
``

### Problem 3.2 : Letters instead of words