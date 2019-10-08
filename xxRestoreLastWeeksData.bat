Echo Step 1 - Replace current parcels with new parcels (46 files)... >> %LogDir%%theDate%.log
 
::Normal copy process: 
 ::XCOPY \\geobase-win\ced\GADS\R2014\R506\Process\data\Pierce_County_FINAL.gdb \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data.gdb /E /I /H /R /Y

::Update 'Pierce_Data20151003.gdb' below to restore last week's copy 
 ::XCOPY \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data20151003.gdb \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data.gdb /E /I /H /R /Y

 dir \\fs005\ArcGISStore\data\PierceCounty\Pierce_Data.gdb 
 time /T 

Echo Step 2 - Count number of parcels... 
 C:\Python27\ArcGISx6410.4\python.exe \\geobase-win\ced\GADS\R2014\R506\Process\fcCount.py 
 time /T 
