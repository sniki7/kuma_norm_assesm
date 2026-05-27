SELECT
        'Hostname check'    as CheckType,
        DeviceVendor                    ,
        DeviceProduct                   ,
        DeviceEventClassID              ,
        DeviceEventCategory             ,
        count(DeviceVendor) AS cnt
FROM
        `events`
WHERE
        Type = '1'
AND     (
                (
                        SourceHostName != ''
                        AND NOT match(SourceHostName, '^[a-zA-Z\_0-9\.\-]+$'))
                OR (
                        DestinationHostName != ''
                        AND NOT match(DestinationHostName, '^[a-zA-Z\_0-9\.\-]+$'))
                OR (
                        DeviceHostName != ''
                        AND NOT match(DeviceHostName, '^[a-zA-Z\_0-9\.\-]+$')) )
GROUP BY
        DeviceVendor      ,
        DeviceProduct     ,
        DeviceEventClassID,
        DeviceEventCategory
ORDER BY
        cnt DESC
LIMIT 1000