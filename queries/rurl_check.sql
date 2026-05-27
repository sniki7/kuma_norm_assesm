SELECT
        'incorrect URL'           AS CheckType,
        DeviceVendor                          ,
        DeviceProduct                         ,
        DeviceEventClassID                    ,
        count(DeviceEventClassID) AS cnt
FROM
        `events`
WHERE
        Type in ('1',
                 '2')
AND     RequestUrl != ''
AND     NOT (
                pathFull(RequestUrl)     != ''
                OR domainRFC(RequestUrl) != ''
                OR domain(RequestUrl)    != '' )
AND     RequestUrl         != 'Unknown'
AND     DeviceEventClassID != 'GNRL_EV_VIRUS_FOUND'
GROUP BY
        CheckType    ,
        DeviceVendor ,
        DeviceProduct,
        DeviceEventClassID
ORDER BY
        cnt DESC
LIMIT 10000