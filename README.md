# CG Lab 1

## 一、基本資料

- **班級：** 資工四 B
- **學號：** 112502021
- **姓名：** 洪瑄伶

## 二、完成項目

### Fundamental

- ✅ **Line Algorithm（25%）**：正確實作直線繪製演算法。
- ✅ **Circle Algorithm（25%）**：正確實作圓形繪製演算法。
- ✅ **Ellipse Algorithm（15%）**：正確實作橢圓繪製演算法。
- ✅ **Bézier Curve Algorithm（15%）**：正確實作貝茲曲線繪製演算法。
- ✅ **Eraser（20%）**：正確實作橡皮擦功能。

### Bonus

- ✅ **筆刷粗細調整：** 可透過鍵盤上的 `+` 和 `-` 按鍵調整筆刷粗細，範圍為 1 至 10。

## 三、程式執行成果

### 1. Line Algorithm



<img width="1242" height="665" alt="Line Algorithm 執行結果" src="https://github.com/user-attachments/assets/79497651-6230-46c8-8247-671cbf4708b3" />

### 2. Circle Algorithm



<img width="1247" height="590" alt="Circle Algorithm 執行結果" src="https://github.com/user-attachments/assets/d44496f6-0d44-4723-98b5-18cf87adb230" />

### 3. Ellipse Algorithm



<img width="1232" height="587" alt="Ellipse Algorithm 執行結果" src="https://github.com/user-attachments/assets/b4a2fe90-b1b8-4b4c-aa01-ef04da0666b6" />

### 4. Bézier Curve Algorithm



<img width="1231" height="582" alt="Bézier Curve Algorithm 執行結果" src="https://github.com/user-attachments/assets/081d0e55-e983-49d4-8011-5ff570478ccb" />

### 5. Eraser



<img width="1227" height="522" alt="Eraser 執行結果" src="https://github.com/user-attachments/assets/d9fc5795-616c-4650-a6a2-6525eeb645d7" />

### 6. Bonus：筆刷粗細調整

按下鍵盤上的 `+` 按鍵可增加筆刷粗細，按下 `-` 按鍵可減少筆刷粗細，調整範圍為 1 至 10

<img width="1232" height="587" alt="image" src="https://github.com/user-attachments/assets/c99c3e11-2e12-44ac-9d93-a933690ea1b7" />

## 四、程式實作說明
### 1. Line Algorithm
實作方式：
1. 計算起點與終點的水平差值 dx 和垂直差值 dy
2. 取兩者絕對值的最大值作為繪製步數，並計算每一步的座標增量
3. 逐步更新座標，使用 Math.round() 將座標四捨五入為整數，再透過 drawPoint() 繪製像素
4. 若起點與終點相同，則直接繪製該點


```
float dx = x2 - x1;
float dy = y2 - y1;

float steps = Math.max(Math.abs(dx), Math.abs(dy));

if (steps == 0) {
    drawPoint(Math.round(x1), Math.round(y1), color(0));
    return;
}

float xIncrement = dx / steps;
float yIncrement = dy / steps;

float currentX = x1;
float currentY = y1;

for (int i = 0; i <= steps; i++) {
    drawPoint(Math.round(currentX), Math.round(currentY), color(0));
    currentX += xIncrement;
    currentY += yIncrement;
```
### 2. Circle Algorithm
使用演算法： 中點圓形繪製演算法（Midpoint Circle Drawing Algorithm）

實作方式：
1. 初始化起始座標 ((p_x,p_y)=(0,r))，並設定決策參數 (d=1-r)
2. 每次迴圈將 (p_x) 加 1。
   若 (d<0)，更新 (d=d+2p_x+3)
   否則將 (p_y) 減 1，並更新 (d=d+2(p_x-p_y)+5)
3. 利用圓形的對稱性，每次繪製八個對稱像素，直到 (p_x>p_y)
```
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
```

### 3. Ellipse Algorithm
使用演算法： 中點橢圓繪製演算法（Midpoint Ellipse Drawing Algorithm）

實作方式：
1. 計算長短半軸的平方，並初始化起始座標與決策參數
2. 將橢圓分為兩個區域：第一區域以 (x) 方向為主要移動方向，第二區域以 (y) 方向為主要移動方向
3. 根據決策參數決定座標更新方式，並利用對稱性繪製像素，直到完成整個橢圓

```
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

```
### 4. Bézier Curve Algorithm
使用演算法： 三次貝茲曲線（Cubic Bézier Curve）

實作方式：
1. 設定四個控制點，並將參數 (t) 從 0 遞增至 1
2. 利用三次貝茲曲線公式計算各參數對應的 (x) 與 (y) 座標
3. 將計算出的座標四捨五入為整數，並使用 drawPoint() 繪製曲線上的像素
```
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
    
```
### 5. Eraser
實作方式：
1. 根據兩個座標點 p1、p2，計算矩形擦除範圍的左右與上下邊界
2. 使用雙層 for 迴圈，逐一遍歷矩形範圍內的像素
3. 透過 drawPoint() 將範圍內的像素改為背景色 color(250)，達到擦除效果
```
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
```
### 6. Bonus：筆刷粗細調整
實作方式：
1. 在主程式宣告全域變數記錄目前筆刷大小，並設定鍵盤方向鍵事件，以即時調整 currentStrokeSize
2. 在各圖形類別（如 Point、Line、Circle 等）中新增變數，記錄圖形建立時的筆刷粗細，並在 drawShape() 繪製前，將 activeStrokeSize 設定為該圖形記錄的粗細
3. 修改底層繪圖函式 drawPoint()，當 activeStrokeSize 大於 1 時，以目標座標為中心，透過雙層 for 迴圈繪製指定大小的像素方塊，實現筆刷加粗效果
```
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
```
## 五、 LLM 使用說明
- 語法除錯與問題排除： 提供 Processing 執行時的錯誤訊息，請 LLM 協助找出並修正語法或邏輯問題
- 數學與演算法協助： 請 LLM 解釋圖學演算法的原理、數學公式及運算邏輯，協助理解實作方式
- 函式查詢與範例參考： 詢問 Processing 繪圖函式的使用方式，並參考範例理解相關功能
- 使用 ChatGPT 調整 README 格式
