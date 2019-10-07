# Download the file from `url` and save it locally under `file_name`:
# Pierce County Tax parcel polygons shapefile
# Updated: 2015-09-10

import urllib
import zipfile
import logging

#Pierce County GIS Data (test) logo Pierce County Open GeoSpatial Data Portal (Beta) - http://gisdata.piercecowa.opendata.arcgis.com/datasets
#url = 'http://gisdata.piercecowa.opendata.arcgis.com/datasets/c913079727094da98a865b57080581df_0.zip'
url = 'http://gisdata.piercecowa.opendata.arcgis.com/datasets/f295195d9eb248e79769104dd70380ad_0.zip'
file_name = "\\\\geobase-win\\ced\\GADS\\R2014\\R506\\Process\\data\\parcel.zip"
unzip_location = "\\\\geobase-win\\ced\\GADS\\R2014\\R506\\Process\\data"

try:
  # Download shapefile 
  urllib.urlretrieve (url, file_name)
  # Unzip - https://docs.python.org/2/library/zipfile.html
  with zipfile.ZipFile(file_name, "r") as z:
      z.extractall(unzip_location)
except:
  logging.exception('\n Unexpected error with website, could not download and unzip successfully: \n')
else:
  print "Parcel download and unzip successful!"
