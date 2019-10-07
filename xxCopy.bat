:: *****************************************************************************
:: UpdateParcels.bat  2/22/2017 
:: Summary: Update parcel data
::
:: Description: The process to update parcels will use a scheduled task to 
::   download the online parcel shapefile, project the shapefile, join the 
::   shapefile to the appropriate assessor tables (Taxpayer, Tax_account, 
::   Appraisal_account), rename the fields to match existing field names, 
::   and send the results to the file geodatabase.  The file geodatabase is
::   then copied to the production site (\\fs005\ArcGISStore\data\PierceCounty).
::
:: Scheduled Task - sometime after 6 am Saturdays (assessor files update)
::
:: Path:\\geobase-win\ced\GADS\R2014\R506\Process\UpdateTS.bat
:: *****************************************************************************

:: Set log directory for process verification file
    SET LogDir=\\geobase-win\ced\GADS\R2014\R506\Process\log\parcel

:: Set variable %theDate% to today's date (YYYYMMDD)
     for /f "tokens=2,3,4 delims=/ " %%a in ('date/t') do set theDate=%%c%%a%%b

:: Record starting time
 time /T > %LogDir%%theDate%.log

::Echo Step 1a - MANUAL METHOD FOR NOW - Downloading parcel data to \\geobase-win\ced\GADS\R2014\R506\Process\data\parcel.zip... >> %LogDir%%theDate%.log
 ::Send standard output (1) & errors (2) to log file
 ::C:\Python27\ArcGISx6410.4\python.exe \\geobase-win\ced\GADS\R2014\R506\Process\Parcel_Download.py 1>>%LogDir%%theDate%.log 2>&1

 time /T >> %LogDir%%theDate%.log

::Echo Step 1b - Downloading assesssor tables... >> %LogDir%%theDate%.log
 ::Send standard output (1) & errors (2) to log file
 ::C:\Python27\ArcGISx6410.4\python.exe \\geobase-win\ced\GADS\R2014\R506\Process\AssessorTable_Download.py 1>>%LogDir%%theDate%.log 2>&1

 time /T >> %LogDir%%theDate%.log


Echo Step 2 - Creating new parcels in \\geobase-win\ced\GADS\R2014\R506\Process\data\Pierce_County.gdb... >> %LogDir%%theDate%.log
 ::C:\Python27\ArcGISx6410.4\python.exe \\geobase-win\ced\GADS\R2014\R506\Process\ParcelUpdate1.py 1>>%LogDir%%theDate%.log 2>&1

 time /T >> %LogDir%%theDate%.log

Echo Step 3 - Deleting existing backup and creating new backup of current parcels with today's date... >> %LogDir%%theDate%.log
 :: Need to use RMDIR in a loop if using wildcards
   ::for /D %%f in (\\fs005\ArcGISStore\data\PierceCounty\Pierce_Data20*) do rmdir %%f /s /q
   ::XCOPY \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data.gdb \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data%theDate%.gdb /I /Y

   time /T >> %LogDir%%theDate%.log

Echo Step 4 - Replace current parcels with new parcels (46 files)... >> %LogDir%%theDate%.log
 XCOPY \\geobase-win\ced\GADS\R2014\R506\Process\data\Pierce_County_FINAL.gdb \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data.gdb /E /I /H /R /Y
 ::XCOPY \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data20151003.gdb \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data.gdb /E /I /H /R /Y
 dir \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data.gdb >> %LogDir%%theDate%.log
 time /T >> %LogDir%%theDate%.log

Echo Step 5 - Count number of parcels... >> %LogDir%%theDate%.log
 C:\Python27\ArcGISx6410.4\python.exe \\geobase-win\ced\GADS\R2014\R506\Process\fcCount.py 1>>%LogDir%%theDate%.log 2>&1
 time /T >> %LogDir%%theDate%.log

Echo Step 6 - Email link to log file... >> %LogDir%%theDate%.log
 C:\Python27\ArcGISx6410.4\python.exe \\geobase-win\ced\GADS\R2014\R506\Process\EmailLogLink.py 1>>%LogDir%%theDate%.log 2>&1
 time /T >> %LogDir%%theDate%.log

Echo  See Pierce County Open GeoSpatial Data Portal (Beta) for latest parcels - https://gisdata-piercecowa.opendata.arcgis.com/datasets/tax-parcels >> %LogDir%%theDate%.log

::For manual testing -
::pause
 
