const fs = require("fs");
const path = require("path");
require("dotenv").config();

const sites = [
    {
        "id": 2002,
        "name": "",
        "title": "",
        "keyword": "",
        "description": "",
        "logo": "",
        "copyright": "Copyright © 2025",
        "footLink": "<a href=\"/about\">关于我们</a>"
    },
]

// 关键词池
const words = [
  "足球比分", "即时比分", "捷报比分", "球探比分", "比分直播", "球探足球比分"
];

/**
 * 生成所有排列 (P(n, k))
 */
function getPermutations(arr, k) {
  const result = [];
  function permute(prefix, rest) {
    if (prefix.length === k) {
      result.push(prefix);
      return;
    }
    for (let i = 0; i < rest.length; i++) {
      permute([...prefix, rest[i]], rest.filter((_, j) => j !== i));
    }
  }
  permute([], arr);
  return result;
}

/**
 * 生成关键词组合文件
 */
function generateKeywordFile() {
  const outputPath = path.join(__dirname, "newOutput/config");
  if (!fs.existsSync(outputPath)) fs.mkdirSync(outputPath);

  const keywordFile = path.join(outputPath, "keyword_combinations.json");

  if (fs.existsSync(keywordFile)) {
    console.log("✅ 关键词组合文件已存在，直接复用。");
    return JSON.parse(fs.readFileSync(keywordFile, "utf-8"));
  }

  const permutations = getPermutations(words, 4);
  console.log(permutations)
  fs.writeFileSync(keywordFile, JSON.stringify(permutations, null, 2), "utf-8");
  console.log(`✅ 已生成关键词组合文件：${keywordFile}`);
  console.log(`📊 共 ${permutations.length} 种排列`);
  return permutations;
}

/**
 * 根据关键词组合，为站点生成配置
 */
function generateSiteConfig(permutations) {
  const outputPath = path.join(__dirname, "newOutput/config");
  if (!fs.existsSync(outputPath)) fs.mkdirSync(outputPath, { recursive: true });

  const updatedSites = sites.map((site, i) => {
    let comboIndex = i % permutations.length;
    let combo = permutations[comboIndex];

    // 如果站点名与关键词组合有重复，则换一个组合
    let retry = 0;
    while (combo.some(w => site.name.includes(w)) && retry < permutations.length) {
      comboIndex = (comboIndex + 1) % permutations.length;
      combo = permutations[comboIndex];
      retry++;
    }

    const title = `${site.name}_${combo.join("_")}`;
    const keyword = `${site.name},${combo.join(",")}`;
    const description = `${site.name}提供足球比分,即时比分,篮球比分查询,与球探比分,捷报比分,体球网,雷速体育等网站齐名是最快比分网,更有世界大小杯赛联赛足球即时比分,足球比分直播,指数分析等专业体育数据！`;

    return {
      ...site,
      title,
      keyword,
      description
    };
  });

  const outputFile = path.join(outputPath, "updated_sites.json");
  fs.writeFileSync(outputFile, JSON.stringify(updatedSites, null, 2), "utf-8");

  console.log(`✅ 已生成 ${updatedSites.length} 个站点配置`);
  console.log(`📁 输出文件：${outputFile}`);
}

/**
 * 主执行逻辑
 */
async function main() {
  const permutations = generateKeywordFile();
  generateSiteConfig(permutations);
}

main();
