SELECT
        'loopback in DeviceAddress' AS CheckType,
        DeviceVendor                            ,
        DeviceProduct                           ,
        DeviceEventClassID                      ,
        count(DeviceEventClassID)   AS cnt
FROM
        `events`
WHERE
        Type in ('1',
                 '2')
AND     (
                inSubnet(DeviceAddress,'127.0.0.0/8')
                OR DeviceAddress = '::1')
GROUP BY
        CheckType    ,
        DeviceVendor ,
        DeviceProduct,
        DeviceEventClassID
ORDER BY
        cnt DESC
LIMIT 10000