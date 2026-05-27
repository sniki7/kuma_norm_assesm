SELECT
        'ip address is missing'   AS CheckType,
        DeviceVendor                          ,
        DeviceProduct                         ,
        DeviceEventClassID                    ,
        count(DeviceEventClassID) AS cnt
FROM
        `events`
WHERE
        Type = '1' 
AND     (
                (
                        SourceAddress          = ''
                        AND SourceHostName     != 'localhost'
                        AND SourcePort         != 0
                        AND DestinationAddress != '')
                OR (
                        DestinationAddress      = ''
                        AND DestinationHostName != 'localhost'
                        AND DestinationPort     != 0)
                AND SourceAddress != '' )
AND     TransportProtocol != ''
GROUP BY
        CheckType    ,
        DeviceVendor ,
        DeviceProduct,
        DeviceEventClassID
ORDER BY
        cnt DESC
LIMIT 10000