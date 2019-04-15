import os
c = get_config()

c.TemplateExporter.template_path.append('/root/.jupyter/nbconvert_templates')
c.LatexExporter.template_file = 'jsarticle'
c.PDFExporter.latex_command = ['ptex2pdf', '-l', '-ot', '-kanji=utf8', '{filename}']
