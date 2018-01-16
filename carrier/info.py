import logging
from logging.handlers import RotatingFileHandler

logger = logging.getLogger('carrier')
logger.setLevel(logging.INFO)

fh = RotatingFileHandler('carrier.log', encoding='UTF-8', maxBytes=1024*1024*200, backupCount=10)
# fh.setLevel(logging.DEBUG)
ch = logging.StreamHandler()
# ch.setLevel(logging.DEBUG)

formatter = logging.Formatter('''%(asctime)s - %(message)s
''')
# formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
fh.setFormatter(formatter)

logger.addHandler(fh)
logger.addHandler(ch)
# logger.info('hello')


