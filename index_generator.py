'''
目次を作成
'''
import pathlib

notebooks = pathlib.Path('notebook')

html_root = pathlib.Path('public')
html_index = html_root / 'index.html'
html_root.mkdir(parents=True, exist_ok=True)

css = '''
<style>
  body {
    font-family: Helvetica, arial, sans-serif;
    font-size: 14px;
    line-height: 1.6;
    padding: 10px 30px; }

  a { color: #4183C4; }

  h1, h2, h3{
    margin: 20px 0 10px;
    padding: 0;
    font-weight: bold;
  }
</style>
'''
title = '<h1>{}</h1>\n'.format(pathlib.Path(__file__).parent.name)
pdf = '<h2>PDF</h2>\n<ul>\n'
html = '<h2>HTML</h2>\n<ul>\n'

for note in notebooks.glob('**/*.ipynb'):
    if '.ipynb_checkpoints' in str(note):
        continue
    path = note.relative_to('notebook')
    pdf += '<li><a href="pdf/{0}.pdf">{0}</a></li>\n'.format(str(path)[:-6])
    html += '<li><a href="html/{0}.html">{0}</a></li>\n'.format(str(path)[:-6])

pdf += '</ul>\n'
html += '</ul>\n'

html_index.write_text(title + css + html + pdf)
