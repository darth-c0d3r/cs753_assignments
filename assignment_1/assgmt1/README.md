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

#### Usage
````
$ chmod 777 ./create-dict-files/create-dict.sh
$ chmod 777 ./lookup-files/lookup-1.sh
$ ./create-dict-files/create-dict.sh lex.txt > fst-files/L.fst
$ ./lookup-files/lookup-1.sh L.fst in.txt ALICE
````

### Problem 3.2 : Letters instead of words

#### Usage

````
$ chmod 777 ./create-dict-files/create-let-dict.sh
$ chmod 777 ./lookup-files/lookup-2.sh
$ ./create-dict-files/create-let-dict.sh lex.txt L.fst > fst-files/Q.fst
$ ./lookup-files/lookup-2.sh Q.fst let-out.txt "A L I C E"
````

### Problem 3.3 : Pronunciations for partial words

#### Usage
````
$ chmod 777 ./create-dict-files/create-prefix-dict.sh
$ chmod 777 ./lookup-files/lookup-3.sh
$ ./create-dict-files/create-prefix-dict.sh Q.fst > fst-files/QPrefix.fst
$ ./lookup-files/lookup-3.sh QPrefix.fst let-out.txt AL
````

### Problem 3.4 : Pronunciations for new words

#### Usage
````
$ chmod 777 ./create-dict-files/setup-merge.sh
$ chmod 777 ./lookup-files/lookup-4.sh
$ ./create-dict-files/setup-merge.sh lex.txt 
$ ./lookup-files/lookup-4.sh QPrefix.fst let-out.txt QSuffix.fst let-out_rev.txt ALIENT
````