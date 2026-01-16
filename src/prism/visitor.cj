/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package cangjie_tpc::prism4cj.prism

/**
 * @see AbsVisitor
 */
public interface Visitor {
    func visit(nodes: ArrayList<Node>): Unit
}

public abstract class AbsVisitor <: Visitor {
    public open override func visit(nodes: ArrayList<Node>): Unit {
        for (i in 0..nodes.size) {
            if (nodes[i].isSyntax()) {
                visitSyntax((nodes[i] as Syntax).getOrThrow())
            } else {
                visitText((nodes[i] as Text).getOrThrow())
            }
        }
    }

    protected func visitText(text: Text): Unit

    // do not forget to call visit(syntax.children()) inside
    protected func visitSyntax(x: Syntax): Unit
}
