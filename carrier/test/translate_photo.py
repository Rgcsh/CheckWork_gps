import base64
data='''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'''
imgdata=base64.b64decode(data)
file=open('1.png','wb')
file.write(imgdata)
file.close()