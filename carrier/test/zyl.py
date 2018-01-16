# -*- coding: utf-8 -*-
import smtplib
from email.mime.multipart import MIMEMultipart
from email.header import Header
from email.mime.application import MIMEApplication
import xlwt

#发送邮箱的配置
M_HOST = 'smtp.qq.com:465'
#发送人
M_SENDER = '2020956572@qq.com'
#密码
M_PWD = 'dshbtaxfdbplcgji'

#发送邮箱
def sm(receiver):
    try:
        msg = MIMEMultipart()
        msg['From'] = M_SENDER
        msg['To'] = receiver
        msg['Subject'] = Header('Subject:张亚玲的作业', charset='UTF-8')  # 中文主题
        # xlsx类型附件
        part = MIMEApplication(open('demo_zuoye.xlsx', 'rb').read())
        part.add_header('Content-Disposition', 'attachment', filename="demo_zuoye.xlsx")
        msg.attach(part)
        smtp = smtplib.SMTP_SSL()
        # smtp = smtplib.SMTP()
        smtp.connect(M_HOST)
        smtp.login(M_SENDER, M_PWD)
        smtp.sendmail(M_SENDER, receiver, msg.as_string())
        smtp.quit()
        print 'The mail to %s is sended successly.' % receiver
    except smtplib.SMTPException, e:
        print "Error: 无法发送邮件", e

def write_excel():
    f = xlwt.Workbook()
    # 创建表格
    sheet1 = f.add_sheet('zyl', cell_overwrite_ok=True)
    # 第一行
    row_five = ['ID', 'CASENAME', 'TYPE', 'URL','PARAMETER','RESULT','Remarks']
    for i in range(0, len(row_five)):
        sheet1.write(0, i, row_five[i])

    #从数据库读取数据，并且插入到表格


    #保存表格

    f.save('demo_zuoye.xlsx')
    print 'save excel success!'
    #发送给任光彩
    sm('2020956572@qq.com')

    # 等所有数据都 成功后，在发送给 这个邮箱
    # sm('zyliu@iflytek.com')
    sm('renguangcai@yoohoor.com')

write_excel()
