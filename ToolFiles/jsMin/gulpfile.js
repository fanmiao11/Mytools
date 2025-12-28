const gulp = require('gulp');
const babel = require('gulp-babel');
const terser = require('gulp-terser');
const rename = require('gulp-rename');
const replace = require('gulp-replace');
const path = require('path');

// ===============================
//   配置区（修改这里即可）
// ===============================
// gulp --gulpfile gulpfile2.js
// const ROOT = '/Users/yys/work/project/GIT/tplhub';
const ROOT = '/Desktop/tplhub';
const START = 1;  // 起始编号
const END   = 6;  // 结束编号（包含）

// 生成目录数组：按规则 ty-qmb / ty-qmb-02 / ty-qmb-10...
const TARGET_DIRS = Array.from(
  { length: END - START + 1 },
  (_, i) => {
    const num = START + i;

    let dirName = 'hy-ty-qmb';

    if (num === 1) {
      // 不拼接编号
    } else if (num < 10) {
      dirName = `${dirName}-0${num}`;
    } else {
      dirName = `${dirName}-${num}`;
    }

    return `${ROOT}/${dirName}`;
  }
);

// ===============================
//   时间戳
// ===============================
function getTimestamp() {
  const now = new Date();
  const pad = (n) => n.toString().padStart(2, '0');
  return (
    now.getFullYear() +
    pad(now.getMonth() + 1) +
    pad(now.getDate()) +
    pad(now.getHours()) +
    pad(now.getMinutes()) +
    pad(now.getSeconds())
  );
}

// ===============================
//   每个目录的配置生成
// ===============================
function getConfig(rootPath) {
  return {
    js: {
      src: [
        `${rootPath}/**/*.js`,
        `!${rootPath}/**/*.min.js`,
        `!${rootPath}/**/node_modules/**`,
        `!${rootPath}/**/dist/**`,
        `!${rootPath}/**/vendor/**`
      ],
      dest: rootPath
    },
    html: {
      src: [
        `${rootPath}/**/*.{html,tpl,php}`,
        `!${rootPath}/**/node_modules/**`
      ],
      dest: rootPath
    }
  };
}

// ===============================
//   JS（单目录）
// ===============================
function minifyJsFactory(rootPath) {
  const config = getConfig(rootPath);

  return function minifyJsTask() {
    return gulp.src(config.js.src)
      .pipe(babel({
        presets: [['@babel/preset-env', { targets: { ie: '11' } }]]
      }))
      .pipe(terser({
        ecma: 5,
        compress: { arrows: false, ecma: 5 },
        output: { ecma: 5, comments: false },
        ie8: true,
        safari10: true
      }))
      .pipe(rename({ suffix: '.min' }))
      .pipe(gulp.dest(config.js.dest));
  };
}

// ===============================
//   HTML（单目录）
// ===============================
function updateHtmlFactory(rootPath) {
  const config = getConfig(rootPath);

  return function updateHtmlTask() {
    const version = getTimestamp();

    return gulp.src(config.html.src)

      // JS版本号
      .pipe(
        replace(/src=(['"])(.*?)\.js(?:\?v=\d+)?\1/g, function (match, quote, filePath) {
          let newPath = filePath;
          if (!newPath.endsWith('.min')) newPath += '.min';
          return `src=${quote}${newPath}.js?v=${version}${quote}`;
        })
      )

      // CSS版本号
      .pipe(
        replace(/(href|src)=(['"])(.*?)\.css(?:\?v=\d+)?\2/g, function (match, attr, quote, filePath) {
          return `${attr}=${quote}${filePath}.css?v=${version}${quote}`;
        })
      )

      .pipe(gulp.dest(config.html.dest));
  };
}

// ===============================
//   汇总任务生成
// ===============================
const jsTasks = TARGET_DIRS.map((dir) => {
  const task = minifyJsFactory(dir);
  task.displayName = `js_${path.basename(dir)}`;
  return task;
});

const htmlTasks = TARGET_DIRS.map((dir) => {
  const task = updateHtmlFactory(dir);
  task.displayName = `html_${path.basename(dir)}`;
  return task;
});

// 默认：先 JS 后 HTML
exports.default = gulp.series(...jsTasks, ...htmlTasks);

// 监听全部目录
exports.watch = function () {
  TARGET_DIRS.forEach((dir) => {
    const config = getConfig(dir);
    gulp.watch(config.js.src, gulp.series(minifyJsFactory(dir), updateHtmlFactory(dir)));
    gulp.watch(config.html.src, updateHtmlFactory(dir));
  });
};

exports.js = gulp.series(...jsTasks);
exports.html = gulp.series(...htmlTasks);
