SELECT
        'incorrect time'          AS CheckType,
        DeviceVendor                          ,
        DeviceProduct                         ,
        DeviceEventClassID                    ,
        count(DeviceEventClassID) AS cnt
FROM
        `events`
WHERE
        Type in ('1',
                 '2')
AND     (
                dateDiff('day',fromUnixTimestamp64Milli(Timestamp),fromUnixTimestamp64Milli(DeviceReceiptTime)) > 1
                OR dateDiff('day',fromUnixTimestamp64Milli(Timestamp),fromUnixTimestamp64Milli(EndTime))        > 1 )
GROUP BY
        CheckType    ,
        DeviceVendor ,
        DeviceProduct,
        DeviceEventClassID
ORDER BY
        cnt DESC
LIMIT 10000