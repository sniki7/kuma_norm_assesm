SELECT 'value limit = 4000 chars' as CheckType, DeviceVendor, DeviceProduct, DeviceEventClassID, count(DeviceEventClassID) as cnt, 

multiIf(min(length(DeviceCustomString1))=4000, 

'limit_dcs1',min(length(DeviceCustomString2))=4000, 

'limit_dcs2',min(length(DeviceCustomString3))=4000, 

'limit_dcs3',min(length(DeviceCustomString4))=4000, 

'limit_dcs4',min(length(DeviceCustomString5))=4000, 

'limit_dcs5',min(length(DeviceCustomString6))=4000,
 
'limit_dcs6','other') as TypeLimit

FROM `events`

WHERE Type in ('1','2') 

AND 

(
    length(DeviceCustomString1) = 4000 
    
    OR

    length(DeviceCustomString2) = 4000 
    
    OR

    length(DeviceCustomString3) = 4000 
    
    OR

    length(DeviceCustomString4) = 4000 
    
    OR

    length(DeviceCustomString5) = 4000 
    
    OR

    length(DeviceCustomString6) = 4000
)

GROUP BY CheckType, DeviceVendor, DeviceProduct, DeviceEventClassID

HAVING startsWith(TypeLimit,'limit')

ORDER BY cnt DESC

LIMIT 10000