SELECT
        'incorrect hash'          AS CheckType,
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
                FileHash       != ''
                OR OldFileHash != '' )
AND     NOT (
                match(FileHash,'^[a-fA-F0-9]{32,128}$')
                OR match(OldFileHash,'^[a-fA-F0-9]{32,128}$') )
AND     DeviceProduct != 'auditd'
GROUP BY
        CheckType    ,
        DeviceVendor ,
        DeviceProduct,
        DeviceEventClassID
ORDER BY
        cnt DESC
LIMIT 10000