LIB_PATH = "lib"
SRC_PATH = "src"
BUILD_PATH = "build/"

compile:
	java -jar "${LIB_PATH}/antlr-4.7.1-complete.jar" -lib "${SRC_PATH}" -visitor "${SRC_PATH}/BigCalc.g4"
	javac -d "${BUILD_PATH}" -cp "${LIB_PATH}/antlr-4.7.1-complete.jar:${SRC_PATH}" -sourcepath "${SRC_PATH}" ${SRC_PATH}/*.java

run:
	java -cp "${LIB_PATH}/antlr-4.7.1-complete.jar:${BUILD_PATH}" BigCalc $(file)

viz:
	java -cp "${LIB_PATH}/antlr-4.7.1-complete.jar:${BUILD_PATH}" org.antlr.v4.gui.TestRig BigCalc expression -gui

clean:
	rm -f ${BUILD_PATH}/*.class
	rm -f ${SRC_PATH}/BigCalc.interp
	rm -f ${SRC_PATH}/BigCalc.tokens
	rm -f ${SRC_PATH}/BigCalcBaseListener.java
	rm -f ${SRC_PATH}/BigCalcBaseVisitor.java
	rm -f ${SRC_PATH}/BigCalcLexer.interp
	rm -f ${SRC_PATH}/BigCalcLexer.java
	rm -f ${SRC_PATH}/BigCalcLexer.tokens
	rm -f ${SRC_PATH}/BigCalcListener.java
	rm -f ${SRC_PATH}/BigCalcParser.java
	rm -f ${SRC_PATH}/BigCalcVisitor.java

