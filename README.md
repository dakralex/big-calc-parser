# BigCalc parser

This is a small parser that can parse calculation expressions and variable
assignments and execute them in such a way that the result of the last program
expression is output after execution.

## Building

To run the project, the Antlr4 4.7.1 complete library must be downloaded, which 
can be done from [here](https://repo1.maven.org/maven2/org/antlr/antlr4/4.7.1/).
Put the `antlr4-4.7.1-complete.jar` file into `lib/` and then proceed with the
build instructions.

### Make

If `make` is installed, you can run the following command to build and run the
parser by specifying the program file with `file=`. For example, to run the
program `tests/program.bc` you can run:

```sh
make file=tests/program.bc run
```

### Manual

If you don't have `make` installed, then you can build the parser on your own:

```sh
java -jar "lib/antlr4-4.7.1-complete.jar" -lib "src/" -visitor "src/BigCalcProg.g4"
javac -d "build/" -cp "lib/antlr4-4.7.1-complete.jar:src/" -sourcepath "src/" src/BigCalcProg*.java
```

After building, the program `tests/program.bc` can be run with:

```sh
java -cp "lib/antlr4-4.7.1-complete.jar:build/" BigCalcProg tests/program.bc
```
