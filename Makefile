LIB_PATH = lib
SRC_PATH = src
BUILD_PATH = build

ANTLR_VERSION = "4.7.1"
ANTLR_COMPLETE_FILE = "antlr4-${ANTLR_VERSION}-complete.jar"

PROG = BigCalcProg


compile:
	java -jar "${LIB_PATH}/${ANTLR_COMPLETE_FILE}" -lib "${SRC_PATH}" -visitor "${SRC_PATH}/$(PROG).g4"
	javac -d "${BUILD_PATH}" -cp "${LIB_PATH}/${ANTLR_COMPLETE_FILE}:${SRC_PATH}" -sourcepath "${SRC_PATH}" ${SRC_PATH}/$(PROG)*.java

run: compile
	java -cp "${LIB_PATH}/${ANTLR_COMPLETE_FILE}:${BUILD_PATH}" $(PROG) $(file)

viz: compile
	java -cp "${LIB_PATH}/${ANTLR_COMPLETE_FILE}:${BUILD_PATH}" org.antlr.v4.gui.TestRig $(PROG) expression -gui

clean:
	rm -f ${BUILD_PATH}/*.class
	rm -f ${SRC_PATH}/$(PROG).interp
	rm -f ${SRC_PATH}/$(PROG).tokens
	rm -f ${SRC_PATH}/$(PROG)BaseListener.java
	rm -f ${SRC_PATH}/$(PROG)BaseVisitor.java
	rm -f ${SRC_PATH}/$(PROG)Lexer.interp
	rm -f ${SRC_PATH}/$(PROG)Lexer.java
	rm -f ${SRC_PATH}/$(PROG)Lexer.tokens
	rm -f ${SRC_PATH}/$(PROG)Listener.java
	rm -f ${SRC_PATH}/$(PROG)Parser.java
	rm -f ${SRC_PATH}/$(PROG)Visitor.java

