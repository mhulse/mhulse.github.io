const fs = require('fs-extra');
const glob = require('glob');
const toc = require('markdown-toc');

const data = [];
const top = '[<img width="32" height="32" align="right" src="https://github.githubassets.com/images/icons/emoji/unicode/261d.png" class="emoji" title="TOC">](#readme)';

//------------------------------------------------------------------------------

function start() {

  glob.sync('**/*.md', { cwd: `./wiki` }).forEach((file, i) => {

    let title = file.replace('.md', '');

    if (title != 'Home') {

      console.log(title);

      data.push(`## [${title.replace(/-/g, ' ')}](../../wiki/${title.replace(/\s/g, '-')})&nbsp;${top}`);

      data.push(
        toc(fs.readFileSync('./wiki/' + file, 'utf8'), {
          linkify: function(tok, text, slug, options) {
            // update tok.content to how you want it
            tok.content = `[${text}](../../wiki/${title}#${slug})`;
            return tok;
          }
        }).content
      );

      data.push('\n');

    }

  });

  fs.writeFileSync('README.md', data.join('\n'));

}

// Stupid simple … this logic could be way better:
start();
