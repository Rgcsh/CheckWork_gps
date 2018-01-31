import cgi

html = '''<script>alert("you are a good boy!&I like you")</scrpit>'''
escape_html = cgi.escape(html)
print escape_html
