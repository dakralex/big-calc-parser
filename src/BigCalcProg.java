import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class BigCalcProg {
    public static void main(String[] args) {
        try {
            CharStream input = CharStreams.fromFileName(args[0]);
            BigCalcProgLexer lexer = new BigCalcProgLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            BigCalcProgParser parser = new BigCalcProgParser(tokens);
            ParseTree tree = parser.program();

            BigCalcProgVisitor<BigDecimal> visitor = new BigCalcProgVisitorImpl();
            BigDecimal result = visitor.visit(tree);

            if (result != null)
                System.out.printf("result: %s%n", result.setScale(10, RoundingMode.HALF_UP));
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("usage: usage: java BigCalcProg <file>");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
