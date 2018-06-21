const fs = require('fs-extra');
const glob = require('glob');
const unzip = require('unzip');
const request = require('request');

const data = [];

glob.sync('**/*.md', { cwd: `./wiki` }).forEach((file, i) => {

	console.log(file, i);

	data.push(`### [${file.replace(/-/g, ' ').replace('.md', '')}](../../wiki/${file.replace(/\s/g, '-')})`);

});

fs.writeFileSync('README.md', data.join('\n'));
