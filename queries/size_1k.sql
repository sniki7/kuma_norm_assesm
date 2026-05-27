SELECT
        'value limit = 1023 chars' as CheckType,
        DeviceVendor,
        DeviceProduct,
		DeviceEventClassID,
        count(DeviceEventClassID)   as cnt,
		
multiIf(

    min(length(DeviceProcessName))=1023, 'limit_devproc',
  
    min(length(DestinationProcessName))=1023, 'limit_dstproc',
    
    min(length(SourceProcessName))=1023, 'limit_srcproc',
    
    min(length(FileName))=1023, 'limit_filename',
    
    min(length(OldFileName))=1023, 'limit_oldfilename',
    
    min(length(RequestClientApplication))=1023, 'limit_RequestClientApplication',
    
    min(length(FilePath))=1023, 'limit_oldfilepath',
    
    'other'
    
) as TypeLimit
  
FROM
        `events`
WHERE
        Type in ('1',
                 '2')
AND     (
                length(DeviceProcessName)           = 1023
                OR length(DestinationProcessName)   = 1023
                OR length(SourceProcessName)        = 1023
                OR length(FileName)                 = 1023
                OR length(OldFileName)              = 1023
                OR length(FilePath)                 = 1023
                OR length(RequestClientApplication) = 1023
                OR length(OldFilePath)              = 1023 )
GROUP BY
        CheckType    ,
        DeviceVendor ,
        DeviceProduct,
        DeviceEventClassID
HAVING
        startsWith(TypeLimit,'limit')
ORDER BY
        cnt DESC
LIMIT 10000