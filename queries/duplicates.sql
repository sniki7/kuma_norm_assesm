SELECT
        'duplicates' AS CheckType,
        DeviceReceiptTime        ,
        EndTime                  ,
        ExternalID               ,
        COUNT(*)     as occurrences
FROM
        `events`
WHERE
        Type IN ('1',
                 '2')
and     ExternalID != ''
GROUP BY
        CheckType        ,
        DeviceReceiptTime,
        EndTime          ,
        ExternalID
HAVING
        COUNT(*) > 1;
