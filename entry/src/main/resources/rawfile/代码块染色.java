```java
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

/**
 * 极简命令行版 Plants vs. Zombies
 *  javac PvZ.java && java PvZ
 */
public class PvZ {

    /* ===================== 常量 ===================== */
    private static final int ROWS = 5;
    private static final int COLS = 9;
    private static final int ZOMBIE_SPAWN_TICK = 10;   // 每 10 轮在最右列产生一只僵尸

    /* ===================== 枚举 ===================== */
    enum Type { PLANT, ZOMBIE, PEA }

    /* ===================== 顶层接口 ===================== */
    interface Entity {
        Type type();
        int row();
        int col();
        int hp();
        void hurt(int dmg);
        boolean isDead();
        void tick(Board b);
        String symbol();        // 用于打印
    }

    /* ===================== 子弹 ===================== */
    static class Pea implements Entity {
        private int row, col;
        Pea(int r, int c) { this.row = r; this.col = c; }
        public Type type() { return Type.PEA; }
        public int row() { return row; }
        public int col() { return col; }
        public int hp() { return 1; }
        public void hurt(int dmg) { /* 子弹不受伤 */ }
        public boolean isDead() { return col >= COLS; }
        public void tick(Board b) {
            col++;                         // 向右飞
            // 击中第一个僵尸
            for (Entity e : b.at(row, col)) {
                if (e.type() == Type.ZOMBIE) {
                    e.hurt(25);
                    b.remove(this);        // 子弹消失
                    return;
                }
            }
        }
        public String symbol() { return "o"; }
    }

    /* ===================== 植物 ===================== */
    static abstract class Plant implements Entity {
        protected int hp, row, col;
        Plant(int hp, int r, int c) { this.hp = hp; this.row = r; this.col = c; }
        public Type type() { return Type.PLANT; }
        public int row() { return row; }
        public int col() { return col; }
        public int hp() { return hp; }
        public void hurt(int dmg) { hp -= dmg; }
        public boolean isDead() { return hp <= 0; }
        public abstract void tick(Board b);
    }

    static class PeaShooter extends Plant {
        private int cd = 0;
        PeaShooter(int r, int c) { super(100, r, c); }
        public void tick(Board b) {
            if (cd > 0) { cd--; return; }
            // 如果本行有僵尸就发射
            boolean hasZombie = b.entities.stream()
                    .anyMatch(e -> e.type() == Type.ZOMBIE && e.row() == row);
            if (hasZombie) {
                b.add(new Pea(row, col + 1));
                cd = 3; // 冷却 3 帧
            }
        }
        public String symbol() { return "P"; }
    }

    /* ===================== 僵尸 ===================== */
    static class BasicZombie implements Entity {
        private int hp = 200, row, col;
        private int atkCD = 0;
        BasicZombie(int r, int c) { row = r; col = c; }
        public Type type() { return Type.ZOMBIE; }
        public int row() { return row; }
        public int col() { return col; }
        public int hp() { return hp; }
        public void hurt(int dmg) { hp -= dmg; }
        public boolean isDead() { return hp <= 0; }
        public void tick(Board b) {
            // 1. 攻击前方植物
            for (Entity e : b.at(row, col - 1)) {
                if (e.type() == Type.PLANT) {
                    if (atkCD == 0) {
                        e.hurt(50);
                        atkCD = 2;
                    }
                    return; // 被挡住不前进
                }
            }
            if (atkCD > 0) atkCD--;
            // 2. 前进
            col--;
            if (col < 0) { b.gameOver = true; } // 进家
        }
        public String symbol() { return "Z"; }
    }

    /* ===================== 游戏主面板 ===================== */
    static class Board {
        List<Entity> entities = new ArrayList<>();
        boolean gameOver = false;
        int sun = 150;
        int tick = 0;

        /* 工具方法 */
        List<Entity> at(int r, int c) {
            return entities.stream()
                    .filter(e -> e.row() == r && e.col() == c)
                    .collect(Collectors.toList());
        }
        void add(Entity e) { entities.add(e); }
        void remove(Entity e) { entities.remove(e); }
        void spawnZombieRandomRow() {
            int r = ThreadLocalRandom.current().nextInt(ROWS);
            add(new BasicZombie(r, COLS - 1));
        }
        /* 每一帧 */
        void tick() {
            tick++;
            // 僵尸生成
            if (tick % ZOMBIE_SPAWN_TICK == 0) spawnZombieRandomRow();

            // 所有实体行动
            new ArrayList<>(entities).forEach(e -> {
                if (!e.isDead()) e.tick(this);
            });

            // 清理死亡
            entities.removeIf(Entity::isDead);
        }

        /* 打印草坪 */
        void render() {
            System.out.println("Sun: " + sun + "   Tick: " + tick);
            for (int r = 0; r < ROWS; r++) {
                StringBuilder sb = new StringBuilder();
                for (int c = 0; c < COLS; c++) {
                    List<Entity> cell = at(r, c);
                    if (cell.isEmpty()) sb.append(" . ");
                    else sb.append(" ").append(cell.get(0).symbol()).append(" ");
                }
                System.out.println(sb);
            }
            System.out.println("----------------------------------");
        }
    }

    /* ===================== 主循环 ===================== */
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Board board = new Board();

        while (!board.gameOver) {
            board.render();
            System.out.print("动作: [p]放豌豆射手 [enter]下一回合 > ");
            String cmd = sc.nextLine().trim();
            if ("p".equalsIgnoreCase(cmd)) {
                System.out.print("输入行(0-4) 列(0-8): ");
                int r = sc.nextInt(), c = sc.nextInt(); sc.nextLine(); // 吃掉换行
                if (r < 0 || r >= ROWS || c < 0 || c >= COLS) {
                    System.out.println("坐标越界");
                    continue;
                }
                if (!board.at(r, c).isEmpty()) {
                    System.out.println("该格已有植物");
                    continue;
                }
                if (board.sun < 100) {
                    System.out.println("阳光不足");
                    continue;
                }
                board.sun -= 100;
                board.add(new PeaShooter(r, c));
            } else if (cmd.isEmpty()) {
                // 什么都不做，进入下一回合
            } else {
                continue;
            }

            // 每回合固定给 25 阳光（模拟向日葵）
            board.sun += 25;
            board.tick();
        }
        System.out.println("僵尸吃掉了你的脑子！游戏结束。");
    }
}