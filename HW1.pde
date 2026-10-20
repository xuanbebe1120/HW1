ShapeButton lineButton;
ShapeButton circleButton;
ShapeButton polygonButton;
ShapeButton ellipseButton;
ShapeButton curveButton;
ShapeButton pencilButton;
ShapeButton eraserButton;

Button clearButton;

ShapeRenderer shapeRenderer;
ArrayList<ShapeButton> shapeButton;
int currentStrokeSize = 1; // 玩家目前選擇的筆刷粗細（預設為 1）
int activeStrokeSize = 1;  // 實際畫圖當下使用的粗細
float eraserSize = 20;

public void setup() {
    size(1000, 800);
    background(255);
    shapeRenderer = new ShapeRenderer();
    initButton();

}

public void draw() {

    background(255);
    for (ShapeButton sb : shapeButton) {
        sb.run(() -> {
            sb.beSelect();
            shapeRenderer.setRenderer(sb.getRendererType());
        });
    }

    clearButton.run(() -> {
        shapeRenderer.clear();
    });
    shapeRenderer.box.show();
    // 新增：確保預覽新圖形時使用當前的筆刷粗細
    activeStrokeSize = currentStrokeSize;
    shapeRenderer.run();
    // 新增：在畫面上方工具列顯示目前的筆刷粗細與操作提示
    fill(0);
    textSize(14);
    text("Brush Size (Press  -  or  +  to change) :" + currentStrokeSize, 270, 30);

}

void resetButton() {
    for (ShapeButton sb : shapeButton) {
        sb.setSelected(false);
    }
}

public void initButton() {
    shapeButton = new ArrayList<ShapeButton>();
    lineButton = new ShapeButton(10, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            line(pos.x + 2, pos.y + 2, pos.x + size.x - 2, pos.y + size.y - 2);
        }

        @Override
        public Renderer getRendererType() {
            return new LineRenderer();
        }
    };

    lineButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(lineButton);

    circleButton = new ShapeButton(45, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            circle(pos.x + size.x / 2, pos.y + size.y / 2, size.x - 2);
        }

        @Override
        public Renderer getRendererType() {
            return new CircleRenderer();
        }
    };
    circleButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(circleButton);

    polygonButton = new ShapeButton(80, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            line(pos.x + 2, pos.y + 2, pos.x + size.x - 2, pos.y + 2);
            line(pos.x + 2, pos.y + size.y - 2, pos.x + size.x - 2, pos.y + size.y - 2);
            line(pos.x + size.x - 2, pos.y + 2, pos.x + size.x - 2, pos.y + size.y - 2);
            line(pos.x + 2, pos.y + 2, pos.x + 2, pos.y + size.y - 2);
        }

        @Override
        public Renderer getRendererType() {
            return new PolygonRenderer();
        }

    };

    polygonButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(polygonButton);

    ellipseButton = new ShapeButton(115, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            ellipse(pos.x + size.x / 2, pos.y + size.y / 2, size.x - 2, size.y * 2 / 3);
        }

        @Override
        public Renderer getRendererType() {
            return new EllipseRenderer();
        }

    };

    ellipseButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(ellipseButton);

    curveButton = new ShapeButton(150, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            bezier(pos.x, pos.y, pos.x, pos.y + size.y, pos.x + size.x, pos.y, pos.x + size.x, pos.y + size.y);
        }

        @Override
        public Renderer getRendererType() {
            return new CurveRenderer();
        }

    };

    curveButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(curveButton);

    clearButton = new Button(width - 50, 10, 30, 30);
    clearButton.setBoxAndClickColor(color(250), color(150));
    clearButton.setImage(loadImage("clear.png"));

    pencilButton = new ShapeButton(185, 10, 30, 30) {
        @Override
        public Renderer getRendererType() {
            return new PencilRenderer();
        }
    };
    pencilButton.setImage(loadImage("pencil.png"));

    pencilButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(pencilButton);

    eraserButton = new ShapeButton(220, 10, 30, 30) {
        @Override
        public Renderer getRendererType() {
            return new EraserRenderer();
        }
    };
    eraserButton.setImage(loadImage("eraser.png"));

    eraserButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(eraserButton);

}

public void keyPressed() {
    if (key == 'z' || key == 'Z') {
        shapeRenderer.popShape();
    }
    // 新增：按 '-' 變細，按 '+' 變粗（限制範圍在 1 ~ 10 之間）
    if (key == '-' || key == '_') {
        currentStrokeSize = max(1, currentStrokeSize - 1);
    }
    if (key == '+' || key == '=') {
        currentStrokeSize = min(10, currentStrokeSize + 1);
    }

}

void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    if (e < 0)
        eraserSize += 1;
    else if (e > 0)
        eraserSize -= 1;
    eraserSize = max(min(eraserSize, 30), 4);
}
