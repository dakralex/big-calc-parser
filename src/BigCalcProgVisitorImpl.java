import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;

public class BigCalcProgVisitorImpl extends BigCalcProgBaseVisitor<BigDecimal> {
    private static final BigDecimal DEFAULT_VALUE = BigDecimal.ZERO;
    private final HashMap<String, BigDecimal> variables = new HashMap<>(0);

    @Override
    public BigDecimal visitProgram(BigCalcProgParser.ProgramContext ctx) {
        BigDecimal res = DEFAULT_VALUE;

        for (BigCalcProgParser.ProgStatementContext progStmtCtx : ctx.progStatement()) {
            res = visit(progStmtCtx);
        }

        return res;
    }

    @Override
    public BigDecimal visitAssigmentStatement(BigCalcProgParser.AssigmentStatementContext ctx) {
        return visit(ctx.assignment());
    }

    @Override
    public BigDecimal visitExpressionStatement(BigCalcProgParser.ExpressionStatementContext ctx) {
        return visit(ctx.expression());
    }

    @Override
    public BigDecimal visitAssignment(BigCalcProgParser.AssignmentContext ctx) {
        String varName = ctx.VariableName().getText();
        BigDecimal varValue = visit(ctx.expression());

        variables.put(varName, varValue);

        return varValue;
    }

    @Override
    public BigDecimal visitVar(BigCalcProgParser.VarContext ctx) {
        String varName = ctx.VariableName().getText();

        BigDecimal varValue = variables.putIfAbsent(varName, DEFAULT_VALUE);

        return varValue != null ? varValue : DEFAULT_VALUE;
    }

    @Override
    public BigDecimal visitNum(BigCalcProgParser.NumContext ctx) {
        return new BigDecimal(ctx.Number().getText());
    }

    @Override
    public BigDecimal visitParens(BigCalcProgParser.ParensContext ctx) {
        return visit(ctx.expression());
    }

    @Override
    public BigDecimal visitAddSub(BigCalcProgParser.AddSubContext ctx) {
        BigDecimal left = visit(ctx.expression(0));
        BigDecimal right = visit(ctx.expression(1));

        return switch (ctx.op.getText()) {
            case "+" -> left.add(right);
            default -> left.subtract(right);
        };
    }

    @Override
    public BigDecimal visitMulDiv(BigCalcProgParser.MulDivContext ctx) {
        BigDecimal left = visit(ctx.expression(0));
        BigDecimal right = visit(ctx.expression(1));

        return switch (ctx.op.getText()) {
            case "*" -> left.multiply(right);
            default -> left.divide(right, 10, RoundingMode.HALF_UP);
        };
    }
}
