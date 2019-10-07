#import time, datetime, smtplib
import time, smtplib

# Local variables:
datestamp = time.strftime('%Y%m%d', time.localtime())

emSubject = 'Parcel Update'
emFrom = 'mmurnane@cityoftacoma.org'
emTo = 'mmurnane@cityoftacoma.org'
fromaddr = ['mmurnane@cityoftacoma.org']
toaddrs = ['mmurnane@cityoftacoma.org']

emMsg = 'See logfile \\\Geobase-win\CED\GADS\R2014\R506\Process\log\parcel' + datestamp + ".log"

from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart('alternative')

msg['Subject'] = emSubject
msg['From'] = emFrom
msg['To'] = emTo

text = emMsg
part1 = MIMEText(text,'plain')

msg.attach(part1)

server=smtplib.SMTP('smtp001.tacoma.lcl')
server.sendmail(fromaddr, toaddrs, msg.as_string())

server.quit
