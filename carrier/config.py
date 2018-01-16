#coding:utf-8
import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config:

    # DB Config
    # =========
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
        'mysql://root:ptdAChu+byhzq2dCc0&MLd@127.0.0.1:3306/carrier?charset=utf8'
    REDIS_URL = "redis://:@localhost:6379/1"
    SQLALCHEMY_COMMIT_ON_TEARDOWN = True
    TOKEN_EXPIRE = 3600*2
    DEBUG = True
    SECRET_KEY = "George Gao is a hero!"
    MAX_CONTENT_LENGTH = 5 * 1024 * 1024
    UPLOAD_FOLDER = 'upload/'
    FRONT_URL = UPLOAD_FOLDER + 'tender_manage/'
    ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif', 'bmp', 'pdf'])

    M_HOST = 'smtp.qq.com:465'
    M_SENDER = '2020956572@qq.com'
    M_PWD = 'dshbtaxfdbplcgji'

    # M_HOST = 'mail.yto.net.cn:25'
    # M_SENDER = 'cyscs@yto.net.cn'
    # M_PWD = os.environ.get('M_PWD') or 'zWEydE1R'
    # ADMINS = ['cyscs@yto.net.cn']

    BAIDU_KEY='6K5WcKZXU3auhy8K15cWmUvWipvYVCMD'  #baidu key
    BAIDU_SERVICE_ID=136114 #服务ID
    BAIDU_URL='http://yingyan.baidu.com/api/v3'
    BAIDU_ALLOW_JSON={'ak':BAIDU_KEY,'service_id': BAIDU_SERVICE_ID}

    @staticmethod
    def init_app(app):
        pass

class DevelopmentConfig(Config):
    SQLALCHEMY_DATABASE_URI = os.environ.get('DEV_DATABASE_URL') or \
        'mysql://root:111111@127.0.0.1:3306/carrier_test?charset=utf8'
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    REDIS_URL = "redis://:@localhost:6379/4"
    # DEBUG_TB_PROFILER_ENABLED = True
    DEBUG_TB_INTERCEPT_REDIRECTS = False
    # DEBUG = True
    DEBUG_TB_PROFILER_ENABLED = True
    DEBUG = True

class KaifaConfig(Config):
    SQLALCHEMY_DATABASE_URI = os.environ.get('DEV_DATABASE_URL') or \
        'mysql://root:aP9RC[0i[6_4EEugz~8@127.0.0.1:3306/carrier_rgc?charset=utf8'
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    REDIS_URL = "redis://:@localhost:6379/4"
    # DEBUG_TB_PROFILER_ENABLED = True
    DEBUG_TB_INTERCEPT_REDIRECTS = False
    # DEBUG = True
    DEBUG_TB_PROFILER_ENABLED = True
    DEBUG = True

class ProductionConfig(Config):
    DEBUG = False


config = {
    'dev': DevelopmentConfig,
    'kai': KaifaConfig,
    'pro': ProductionConfig
}