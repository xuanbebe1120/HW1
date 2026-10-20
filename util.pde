public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).

    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */
    float dx = x2 - x1;
    float dy = y2 - y1;
    // 決定總共要畫多少個點 
    float steps = Math.max(Math.abs(dx), Math.abs(dy));
    // 預防起點和終點完全同一個座標的狀況
    if (steps == 0) {
        drawPoint(Math.round(x1), Math.round(y1), color(0)); 
        return;
    }
    float xIncrement = dx / steps;
    float yIncrement = dy / steps;
    float currentX = x1;
    float currentY = y1;
    for (int i = 0; i <= steps; i++) {
        // 必須用 Math.round 四捨五入成整數，才能畫在螢幕像素上
        drawPoint(Math.round(currentX), Math.round(currentY), color(0));
        currentX += xIncrement;
        currentY += yIncrement;
    }
 
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
    int xc = round(x);
    int yc = round(y);
    int radius = round(r);
    
    int px = 0;
    int py = radius;
    int d = 1 - radius;

    while (px <= py) {
        drawPoint(xc + px, yc + py, color(0));
        drawPoint(xc - px, yc + py, color(0));
        drawPoint(xc + px, yc - py, color(0));
        drawPoint(xc - px, yc - py, color(0));
        drawPoint(xc + py, yc + px, color(0));
        drawPoint(xc - py, yc + px, color(0));
        drawPoint(xc + py, yc - px, color(0));
        drawPoint(xc - py, yc - px, color(0));

        if (d < 0) {
            d += 2 * px + 3;
        } else {
            d += 2 * (px - py) + 5;
            py--;
        }
        px++;
    }
    
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */
    
    int xc = round(x);
    int yc = round(y);
    int rx = round(r1);
    int ry = round(r2);

    int rx2 = rx * rx;
    int ry2 = ry * ry;

    int px = 0;
    int py = ry;

    // Region 1 的初始決策參數
    float d1 = ry2 - rx2 * ry + 0.25 * rx2;

    // Region 1
    while (2 * ry2 * px < 2 * rx2 * py) {
        drawPoint(xc + px, yc + py, color(0));
        drawPoint(xc - px, yc + py, color(0));
        drawPoint(xc + px, yc - py, color(0));
        drawPoint(xc - px, yc - py, color(0));

        if (d1 < 0) {
            px++;
            d1 += 2 * ry2 * px + ry2;
        } else {
            px++;
            py--;
            d1 += 2 * ry2 * px - 2 * rx2 * py + ry2;
        }
    }

    // Region 2 的初始決策參數
    float d2 = ry2 * (px + 0.5) * (px + 0.5)
             + rx2 * (py - 1) * (py - 1)
             - rx2 * ry2;

    // Region 2
    while (py >= 0) {
        drawPoint(xc + px, yc + py, color(0));
        drawPoint(xc - px, yc + py, color(0));
        drawPoint(xc + px, yc - py, color(0));
        drawPoint(xc - px, yc - py, color(0));

        if (d2 > 0) {
            py--;
            d2 += rx2 - 2 * rx2 * py;
        } else {
            px++;
            py--;
            d2 += 2 * ry2 * px - 2 * rx2 * py + rx2;
        }
    }

}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
        // Bezier Curve Algorithm

    int steps = 1000;

    for (int i = 0; i <= steps; i++) {
        // 將 i 轉換成 0 到 1 之間的參數 t
        float t = i / (float) steps;
        float u = 1 - t;

        // 使用三次 Bezier 曲線公式計算座標
        float x = u * u * u * p1.x
                + 3 * u * u * t * p2.x
                + 3 * u * t * t * p3.x
                + t * t * t * p4.x;

        float y = u * u * u * p1.y
                + 3 * u * u * t * p2.y
                + 3 * u * t * t * p3.y
                + t * t * t * p4.y;

        drawPoint(round(x), round(y), color(0));
    }
    
    
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    // 找出矩形的左右上下邊界
    int minX = round(min(p1.x, p2.x));
    int maxX = round(max(p1.x, p2.x));
    int minY = round(min(p1.y, p2.y));
    int maxY = round(max(p1.y, p2.y));

    // 將矩形範圍內的像素改成背景色
    for (int x = minX; x <= maxX; x++) {
        for (int y = minY; y <= maxY; y++) {
            drawPoint(x, y, color(250));
        }
    }
}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    // 如果粗細為 1，直接畫
    if (activeStrokeSize <= 1) {
        point(x, y);
        return;
    }
    // 如果粗細大於 1，以 (x, y) 為中心點畫出 activeStrokeSize x activeStrokeSize 的像素方塊
    int half = activeStrokeSize / 2;
    for (int dx = -half; dx < activeStrokeSize - half; dx++) {
        for (int dy = -half; dy < activeStrokeSize - half; dy++) {
            point(x + dx, y + dy);
        }
    }
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
