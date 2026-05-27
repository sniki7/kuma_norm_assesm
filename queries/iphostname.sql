SELECT
        'ip address in hostname'  as CheckType,
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
                        SourceHostName     != ''
                        AND SourceHostName != SourceAddress
                        AND (
                                NOT (
                                        toIPv4OrNull(SourceHostName) IS NULL)
                                OR NOT (
                                        toIPv6OrNull(SourceHostName) IS NULL) ) )
                OR (
                        DestinationHostName     != ''
                        AND DestinationHostName != DestinationAddress
                        AND (
                                NOT (
                                        toIPv4OrNull(DestinationHostName) IS NULL)
                                OR NOT (
                                        toIPv6OrNull(DestinationHostName) IS NULL) ) )
                OR (
                        DeviceHostName     != ''
                        AND DeviceHostName != DeviceAddress
                        AND (
                                NOT (
                                        toIPv4OrNull(DeviceHostName) IS NULL)
                                OR NOT (
                                        toIPv6OrNull(DeviceHostName) IS NULL) ) ) )
GROUP BY
        CheckType    ,
        DeviceVendor ,
        DeviceProduct,
        DeviceEventClassID
ORDER BY
        cnt DESC
LIMIT 10000