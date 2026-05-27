SELECT
        'Vendor-product check' as CheckType,
        ServiceName                        ,
        DeviceVendor                       ,
        DeviceProduct                      ,
        count(ServiceName)     as SvcEvCnt
FROM
        `events`
WHERE
        Type = '1'
AND     (
                DeviceVendor     = ''
                OR DeviceProduct = '')
GROUP BY
        ServiceName ,
        DeviceVendor,
        DeviceProduct
ORDER BY
        SvcEvCnt DESC
LIMIT 500