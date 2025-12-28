const axios = require('axios');
const readline = require('readline');
require('dotenv').config();

const config = {
  token: process.env.TOKEN,
  domain: process.env.DOMAIN
};

const domains = [
  {
    "id": 333,
    "name": "",
    "domainId": 332,
    "templateId": 862,
    "domainName": "https://xxx.com",
    "secondary": [
        "xxx.com"
    ]
  },
]

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// 组装要提交的域名数据
function buildDomainList(item, mode) {
  const result = [];

  if (mode === 'primary' || mode === 'all') {
    result.push({
      ...item,
      domains: [item.primary]
    });
  }

  if ((mode === 'secondary' || mode === 'all') && Array.isArray(item.secondary)) {
    for (const sec of item.secondary) {
      result.push({
        ...item,
        domains: [sec]
      });
    }
  }

  return result;
}

async function addDomains(mode) {
  if (domains.length === 0) {
    console.log('没有新域名需要添加！');
    return;
  }

  const failedDomains = []; // 记录失败的域名

  for (const item of domains) {
    const domainList = buildDomainList(item, mode);

    for (const domainData of domainList) {
      const domainName = domainData.domains[0];
      console.log(`开始添加域名: 《${item.name}》 - ${domainName} - ${domainData.ip}`);

      try {
        const response = await axios.post(
          `${config.domain}/api/managed/domain/add`,
          { domains: [{ name: domainName, ip: domainData.ip}] },
          {
            headers: {
              'Content-Type': 'application/json',
              'Authorization': config.token,
              'Site': ''
            }
          }
        );

        if (response.data.code === 200) {
          console.log(`✅ 添加成功: 《${item.name}》 - ${domainName}`);
        } else {
          console.error(`⚠️ 添加失败 (状态码 ${response.status}): 《${item.name}》 - ${domainName}`, response.data);
          failedDomains.push(domainName);
        }
      } catch (error) {
        console.error(`❌ 添加请求失败: 《${item.name}》 - ${domainName}`, error.response?.data || error.message || error);
        failedDomains.push(domainName);
      }

      await sleep(500);
    }
  }

  console.log(`\n添加任务完成`);
  if (failedDomains.length > 0) {
    console.log(`❌ 以下域名添加失败: ${failedDomains.join(', ')}`);
  } else {
    console.log(`🎉 所有域名添加成功！`);
  }
}

// 关联主域名和副域名
async function aliasDomains() {
  for (const item of domains) {
    if (!item.secondary || item.secondary.length === 0) {
      console.log(`⚠️ 《${item.name}》 没有副域名，跳过关联`);
      continue;
    }

    console.log(`开始关联主域名: 《${item.name}》 ⇨ [${item.secondary.join(', ')}]`);
    console.log(item.id, item.secondary)

    try {
      const response = await axios.post(
        `${config.domain}/api/managed/domain/alias`,
        {
          siteId: item.id,
          aliases: item.secondary
        },
        {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': config.token,
            'Site': ''
          }
        }
      );

      if (response.status === 200 && response.data.code === 200) {
        console.log(`✅ 关联成功: 《${item.name}》`);
      } else {
        console.error(`⚠️ 关联失败 (状态码 ${response.status}): 《${item.name}》`, response.data);
      }
    } catch (error) {
      console.error(`❌ 关联请求失败: 《${item.name}》`, error.response?.data || error.message || error);
    }

    await sleep(2000);
  }
  console.log(`\n关联任务完成`);
}

function chooseMode() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  console.log(`
请选择添加模式：
1. 只添加 primary 域名
2. 只添加 secondary 域名
3. 添加所有域名 (primary + secondary)
4. 关联主域名和副域名
`);

  rl.question("请输入选项 (1/2/3/4): ", (answer) => {
    let mode;
    switch (answer.trim()) {
      case '1':
        mode = 'primary';
        rl.close();
        addDomains(mode);
        break;
      case '2':
        mode = 'secondary';
        rl.close();
        addDomains(mode);
        break;
      case '3':
        mode = 'all';
        rl.close();
        addDomains(mode);
        break;
      case '4':
        rl.close();
        aliasDomains();
        break;
      default:
        console.log("无效的选项，请输入 1 / 2 / 3 / 4");
        rl.close();
        return;
    }
  });
}

chooseMode();
