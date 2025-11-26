SELECT system_id
      ,RetirementSystemName
      ,RetirementSystemDesc
      ,RetirementSystemStateAbbrev
      ,NumberofPlans
      ,sys_DataStartYear
      ,sys_DataEndYear
      ,ppd_system_directory_listed
  FROM FullDataSet;

-- Select by distinct retirement systems (no duplicates)
SELECT DISTINCT system_id
      ,RetirementSystemName
      ,RetirementSystemDesc
      ,RetirementSystemStateAbbrev
      ,NumberofPlans
      ,sys_DataStartYear
      ,sys_DataEndYear
      ,ppd_system_directory_listed
  FROM FullDataSet
  ORDER BY RetirementSystemStateAbbrev;

-- View total retirement systems per state
SELECT COUNT(DISTINCT RetirementSystemName) AS TotalRetSystemsPerState, RetirementSystemStateAbbrev
  FROM FullDataSet
  GROUP BY RetirementSystemStateAbbrev
  ORDER BY TotalRetSystemsPerState DESC;


/* DATA ANALYSIS */
SELECT
    -- Get total number of distinct retirement system plans  
    COUNT(DISTINCT RetirementSystemName) AS [TotalRetSystems],
    -- Calculate average number of plans per retirement system
    AVG(CONVERT(int, NumberofPlans)) AS [AvgNumberOfPlans],
    -- Calculate average number of retirement systems per state
    (SELECT AVG(AvgRetSystemPerState)
    FROM (
        SELECT COUNT(DISTINCT RetirementSystemName) AS AvgRetSystemPerState
        FROM FullDataSet
        GROUP BY RetirementSystemStateAbbrev
    ) A) AS [AvgRetSystemPerState]
  FROM FullDataSet;