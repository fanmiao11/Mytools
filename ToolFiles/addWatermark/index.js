const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

// --- 配置 ---
const inputDir = path.join(__dirname, 'img');
const outputDir = path.join(__dirname, 'output');
const watermarkText = "007666.com";

// 水印样式 (保持不变)
const watermarkOptions = {
    fontSize: 16,
    padding: 10,
    fill: 'rgba(255, 255, 255, 0.7)',
    fontWeight: 900
};

// 允许处理的图片扩展名 (保持不变)
const allowedExtensions = ['.jpg', '.jpeg', '.png', '.webp', '.gif', '.bmp'];
// --- 结束配置 ---


/**
 * 创建水印 SVG 缓存 (保持不变)
 */
function createWatermarkSvg(text, angle = -20) {
    const estimatedWidth = (text.length * watermarkOptions.fontSize) + (watermarkOptions.padding * 2);
    const estimatedHeight = watermarkOptions.fontSize + (watermarkOptions.padding * 2);

    const textX = estimatedWidth - watermarkOptions.padding;
    const textY = estimatedHeight - watermarkOptions.padding - (watermarkOptions.fontSize * 0.1);

    const svg = `
    <svg width="${estimatedWidth}" height="${estimatedHeight * 2}" xmlns="http://www.w3.org/2000/svg">
        <g transform="rotate(${angle}, ${textX}, ${textY})">
            <text
                x="${textX}"
                y="${textY}"
                font-family="sans-serif"
                font-size="${watermarkOptions.fontSize}"
                fill="${watermarkOptions.fill}"
                font-weight="${watermarkOptions.fontWeight}"
                stroke="${watermarkOptions.stroke}"
                stroke-width="${watermarkOptions.strokeWidth}"
                text-anchor="end"
            >
                ${text}
            </text>
        </g>
    </svg>
  `;
    return Buffer.from(svg);
}

// ==========================================================
//  *** 更新的 addWatermark 函数 ***
// ==========================================================
/**
 * 处理单张图片 (已更新)
 */
async function addWatermark(filename, watermarkBuffer) {
    const inputPath = path.join(inputDir, filename);
    const outputPath = path.join(outputDir, filename);
    const ext = path.extname(filename).toLowerCase();

    try {
        let image = sharp(inputPath);

        // 1. 保留元数据 (包含 ICC 色彩配置)
        image = image.withMetadata();

        // 2. 复合水印
        const watermarkedImage = image.composite([
            {
                input: watermarkBuffer,
                gravity: 'southeast' // 右下角
            }
        ]);

        // 3. 根据不同格式，使用最高质量设置保存
        if (ext === '.jpg' || ext === '.jpeg') {
            await watermarkedImage
                .jpeg({
                    quality: 85,           // 最高 JPEG 质量
                    chromaSubsampling: '4:4:4' // 保留完整色彩信息
                })
                .toFile(outputPath);

        } else if (ext === '.png') {
            // PNG 本身是无损的，默认设置即可保留质量
            await watermarkedImage
                .png()
                .toFile(outputPath);

        } else if (ext === '.webp') {
            await watermarkedImage
                .webp({
                    lossless: true          // 使用无损 WebP 模式
                })
                .toFile(outputPath);

        } else {
            // 对于 GIF, BMP 等，让 sharp 自动处理
            await watermarkedImage.toFile(outputPath);
        }

        console.log(`[成功] 已添加水印: ${outputPath}`);
    } catch (err) {
        console.error(`[失败] 处理 ${filename} 时出错:`, err.message);
    }
}
// ==========================================================
//  *** 函数更新结束 ***
// ==========================================================


/**
 * 主执行函数 (保持不变)
 */
async function processImages() {
    console.log(`开始处理 ${inputDir} 中的图片...`);
    console.log(`输出目录: ${outputDir}`);

    if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
        console.log(`已创建输出目录: ${outputDir}`);
    }

    const watermarkBuffer = createWatermarkSvg(watermarkText);

    let files;
    try {
        files = await fs.promises.readdir(inputDir);
    } catch (err) {
        console.error(`[错误] 无法读取输入目录: ${inputDir}`, err);
        return;
    }

    const imageFiles = files.filter(file => {
        const ext = path.extname(file).toLowerCase();
        return allowedExtensions.includes(ext);
    });

    if (imageFiles.length === 0) {
        console.warn(`在 ${inputDir} 中未找到可处理的图片文件。`);
        return;
    }

    console.log(`找到 ${imageFiles.length} 张图片，开始添加水印...`);

    for (const file of imageFiles) {
        await addWatermark(file, watermarkBuffer);
    }

    console.log('--- 全部处理完成 ---');
}

// 运行脚本
processImages();