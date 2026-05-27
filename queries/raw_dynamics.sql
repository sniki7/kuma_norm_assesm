SELECT 'Raw-dynamics' as CheckType, concat(if(DeviceVendor = '','Other',DeviceVendor),' ',if(DeviceProduct = '','Other',DeviceProduct)) AS value, 

countIf(Timestamp between toUnixTimestamp64Milli(now64()) - 24*3600000 and toUnixTimestamp64Milli(now64())) AS today,

countIf(Timestamp between toUnixTimestamp64Milli(now64()) - 48*3600000 and toUnixTimestamp64Milli(now64())-24*3600000) AS yesterday,

multiIf(today=0,toFloat32(yesterday)*-1,yesterday=0,toFloat32(today),today>yesterday,round(today/yesterday,2),today<yesterday,round(yesterday/today,2)*-1,1) AS metric 

FROM `events` 

WHERE Type = 1 AND Raw != ''

GROUP BY value 

HAVING ABS(metric) > 1.3

ORDER BY ABS(metric) DESC