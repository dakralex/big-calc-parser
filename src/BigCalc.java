import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;

public class BigCalc {
    public static void main(String[] args) {
        try {
            CharStream input = CharStreams.fromFileName(args[0]);
            BigCalcLexer lexer = new BigCalcLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            BigCalcParser parser = new BigCalcParser(tokens);
            ParseTree tree = parser.expressionStatement();

            BigCalcVisitor<BigDecimal> visitor = new BigCalcVisitorImpl();
            BigDecimal result = visitor.visit(tree);

            if (result != null)
                System.out.println("result: " + result.setScale(10, RoundingMode.HALF_UP));
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("usage: usage: java BigCalc <file>");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
