# Download the latest Assessor Tables from FTP site
# 
# Last Update: 2015-2-9

import glob
import shutil
import os
import ftplib
import logging
import time

try:
    # Variables
    path = r'\\fs005\ArcGISStore\data\PierceCounty\AssessorTables'
    pathTextFiles = path + r'\*.txt'
    pathBackUp = path + r'\LastWeeksFiles'

    # Make backup copy of previous tables (*.txt)
    print "Creating backup copies of assessor tables (*.txt)..."
    for file in glob.glob(pathTextFiles):
        print file                                                                                                                                        
        shutil.copy(file, pathBackUp)
    
    # Connect to the FTP site
    print "Connecting to the FTP site....."
    ftp = ftplib.FTP('ftp.cityoftacoma.org','cedftp','M8Xsk;J,')

    # After connecting, change to subfolder
    ftp.cwd("ATS")
    print "Change directory to the ATS subfolder on the FTP website"

    #Start the data download  (*.txt)
    print ftp.retrlines('LIST')  # show ftp file details
    filenames = ftp.nlst('*.txt') # get filenames within the directory
    #print filenames
    
    for filename in filenames:
        print "Downloading " + filename + " table from FTP site"
        local_filename = os.path.join(path, filename)
        file = open(local_filename, 'wb')
        ftp.retrbinary('RETR '+ filename, file.write)

        file.close()

    print "Closing the FTP connection..."
    ftp.quit() # close a connection

except:
    logging.exception('\n Unexpected error with FTP site, could not download tables successfully: \n')
else:
    print "Assessor tables copy successful!  Check file dates."
