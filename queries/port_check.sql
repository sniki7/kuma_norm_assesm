SELECT
        'port_range'              as CheckType,
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
                (
                        SourcePort != 0
                        AND (
                                SourcePort    < -1
                                OR SourcePort > 65535))
                OR (
                        DestinationPort != 0
                        AND (
                                DestinationPort    < -1
                                OR DestinationPort > 65535)) )
GROUP BY
        CheckType    ,
        DeviceVendor ,
        DeviceProduct,
        DeviceEventClassID
ORDER BY
        cnt DESC
LIMIT 10000