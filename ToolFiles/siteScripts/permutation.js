const fs = require("fs");
const path = require("path");

const input = "球探足球比分,足球比分,即时比分,足球比分直播,球探比分,捷报比分,足球即时比分,篮球比分";

// 输出文件路径
const outputFile = path.join(__dirname, "output/permutation", "permutations.json");

// 确保输出目录存在
fs.mkdirSync(path.dirname(outputFile), { recursive: true });

// 拆分成数组
const words = input.split(",");

// 从数组中选出 n 个的组合
function getCombinations(arr, n) {
  const result = [];
  function helper(start, combo) {
    if (combo.length === n) {
      result.push([...combo]);
      return;
    }
    for (let i = start; i < arr.length; i++) {
      combo.push(arr[i]);
      helper(i + 1, combo);
      combo.pop();
    }
  }
  helper(0, []);
  return result;
}

// 对一个数组进行全排列
function getPermutations(arr) {
  const result = [];
  function helper(path, options) {
    if (options.length === 0) {
      result.push(path);
      return;
    }
    for (let i = 0; i < options.length; i++) {
      helper([...path, options[i]], options.filter((_, idx) => idx !== i));
    }
  }
  helper([], arr);
  return result;
}

// 取出5个的组合
const combos = getCombinations(words, 5);

// 对每个组合做全排列，并用逗号拼接成字符串
let allResults = [];
combos.forEach(combo => {
  const perms = getPermutations(combo);
  perms.forEach(p => {
    allResults.push(p.join(","));
  });
});

// 写入 JSON 文件
fs.writeFileSync(outputFile, JSON.stringify(allResults, null, 2), "utf8");

console.log(`已生成 ${allResults.length} 条排列组合，保存到 ${outputFile}`);
