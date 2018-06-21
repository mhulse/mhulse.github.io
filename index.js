const fs = require('fs-extra');
const glob = require('glob');
const unzip = require('unzip');
const request = require('request');

const data = [];

glob.sync('**/*.md', { cwd: `./wiki` }).forEach((file, i) => {

	console.log(file, i);
	
	file = file.replace('.md', '');

	data.push(`* [${file.replace(/-/g, ' ')}](../../wiki/${file.replace(/\s/g, '-')})`);

});

fs.writeFileSync('README.md', data.join('\n'));
