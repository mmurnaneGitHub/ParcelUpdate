# Name: fcCount.py
# Purpose: calculate the number of features in a featureclass
# http://resources.arcgis.com/en/help/main/10.2/index.html#//0017000000n7000000

# Import system modules
import arcpy

arcpy.env.workspace = "\\\\fs005\ArcGISStore\\data\\PierceCounty\\Pierce_Data.gdb"
print "Parcel count: " 
print arcpy.GetCount_management("TaxParcel")