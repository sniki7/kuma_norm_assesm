SELECT
        'Extra check'          as CheckType,
        DeviceVendor                       ,
        DeviceProduct                      ,
        DeviceEventClassID                 ,
        DeviceEventCategory                ,
        max(JSONLength(Extra)) AS maxJSON
FROM
        `events`
WHERE
        Extra             != ''
AND     JSONLength(Extra) > 50
GROUP BY
        DeviceVendor      ,
        DeviceProduct     ,
        DeviceEventClassID,
        DeviceEventCategory
ORDER BY
        maxJSON DESC
LIMIT 1000